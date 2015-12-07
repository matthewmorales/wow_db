class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy]

  # GET /characters
  # GET /characters.json
  def index
    @characters = Character.all
  end

  # GET /characters/1
  # GET /characters/1.json
  def show
  end

  # GET /characters/new
  def new
    @character = Character.new
  end

  # GET /characters/1/edit
  def edit
  end

  # POST /characters
  # POST /characters.json
  def create
    @character = Character.new(character_params)

    name = URI.encode(@character.name)
    locale = @character.locale
    realm = @character.realm

    char_response = HTTParty.get('https://us.api.battle.net/wow/character/' + realm + '/' + name + '?fields=guild&fields=items&fields=stats&locale=' + locale + '&apikey=buhtgm3aaumgx38c5erhud2trk4vmzd2') 
    character = JSON.parse(char_response.body)
    guild_response = character["guild"]
    stat_response = character["stats"]
    armor_response = character["items"]["chest"]
    tabard_response = character["items"]["tabard"]
    mh_response = character["items"]["mainHand"]
    oh_response = character["items"]["offHand"]
    guild_response.delete("emblem")
    g_name = guild_response["name"]

    if armor_response != nil && (@armor = Armor.find_by(:name => armor_response["name"])) != nil
      @character.armor_id = @armor.id
    elsif armor_response != nil
      armor_response.delete("icon")
      armor_response.delete("tooltipParams")
      armor_response.delete("stats")
      armor_response.delete("bonusLists")
      @armor = Armor.new(armor_response)
      @armor.save
    end

    if stat_response != nil && (@stat = Stat.find_by(:character_id => @character.id)) != nil
      @character.stat_id = @stat.id
    elsif stat_response != nil
      stats = Hash.new
      stats["health"] = stat_response["health"]
      stats["powerType"] = stat_response["powerType"]
      stats["power"] = stat_response["power"]
      stats["str"] = stat_response["str"]
      stats["agi"] = stat_response["agi"]
      stats["int"] = stat_response["int"]
      stats["sta"] = stat_response["sta"]
      stats["crit"] = stat_response["crit"]
      stats["haste"] = stat_response["haste"]
      stats["mastery"] = stat_response["mastery"]
      stats["bonusArmor"] = stat_response["bonusArmor"]
      stats["spellPower"] = stat_response["spellPower"]
      stats["armor"] = stat_response["armor"]
      stats["parry"] = stat_response["parry"]
      stats["block"] = stat_response["block"]
      stats["attackPower"] = stat_response["attackPower"]
      stats["rangedAttackPower"] = stat_response["rangedAttackPower"]
      stats["mainHandDps"] = stat_response["mainHandDps"]
      stats["character_id"] = @character.id
      @stat = Stat.new(stats)
      @stat.save
    end

    if mh_response != nil && (@mainhand = Mainhand.find_by(:name => mh_response["name"], :itemLevel => mh_response["itemLevel"])) != nil
      @character.mainhand_id = @mainhand.id
    elsif mh_response != nil
      mh_response.delete("icon")
      mh_response.delete("tooltipParams")
      mh_response.delete("stats")
      mh_response.delete("armor")
      mh_response["dps"] = mh_response["weaponInfo"]["dps"]
      mh_response.delete("weaponInfo")
      mh_response.delete("bonusLists")
      @mainhand = Mainhand.new(mh_response)
      @mainhand.save
    end

    if oh_response != nil && (@offhand = Offhand.find_by(:name => oh_response["name"], :itemLevel => oh_response["itemLevel"])) != nil
      @character.offhand_id = @offhand.id
    elsif oh_response != nil
      oh_response.delete("icon")
      oh_response.delete("tooltipParams")
      oh_response.delete("stats")
      if oh_response.has_key?("weaponInfo")
        oh_response["dps"] = oh_response["weaponInfo"]["dps"]
      else
        oh_response["dps"] = 0
      end
      oh_response.delete("weaponInfo")
      oh_response.delete("bonusLists")
      @offhand = Offhand.new(oh_response)
      @offhand.save
    end


    if tabard_response != nil && (@tabard = Tabard.find_by(:name => tabard_response["name"])) != nil
      @character.tabard_id = @tabard.id
    elsif tabard_response != nil
      tabard_response.delete("icon")
      tabard_response.delete("tooltipParams")
      tabard_response.delete("stats")
      tabard_response.delete("bonusLists")
      @tabard = Tabard.new(tabard_response)
      @tabard.save
    end


    if guild_response != nil && (@guild = Guild.find_by(:name => g_name, :realm => realm)) != nil
      @character.guild_id = @guild.id
    elsif guild_response != nil
      @guild = Guild.new(guild_response)
      @guild.save
    end

    level  = character["level"]
    race = character["race"]
    char_class = character["class"]
    bgroup = character["battlegroup"]
    achv_pts = character["achievementPoints"]
    h_kills = character["totalHonorableKills"]
    faction = (character["faction"] == 0) ? "A" : "H"
    gender = (character["gender"] == 0) ? "M" : "F"

    @character.level = level
    @character.race = race
    @character.char_class = char_class
    @character.battle_group = bgroup
    @character.achievements_points = achv_pts
    @character.honorable_kills = h_kills
    @character.faction = faction
    @character.gender = gender

    respond_to do |format|
      if @character.save
        format.html { redirect_to @character, notice: 'Character was successfully created.' }
        format.json { render :show, status: :created, location: @character }
      else
        format.html { render :new }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /characters/1
  # PATCH/PUT /characters/1.json
  def update
    respond_to do |format|
      if @character.update(character_params)
        format.html { redirect_to @character, notice: 'Character was successfully updated.' }
        format.json { render :show, status: :ok, location: @character }
      else
        format.html { render :edit }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /characters/1
  # DELETE /characters/1.json
  def destroy
    @character.destroy
    respond_to do |format|
      format.html { redirect_to characters_url, notice: 'Character was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character
      @character = Character.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def character_params
      params.require(:character).permit(:name, :locale, :realm)
    end
end
