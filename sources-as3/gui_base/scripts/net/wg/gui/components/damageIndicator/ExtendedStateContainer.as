package net.wg.gui.components.damageIndicator
{
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.DAMAGEINDICATOR;
   import scaleform.gfx.TextFieldEx;
   
   public class ExtendedStateContainer extends StandardStateContainer
   {
      
      private static const TANK_ICON_Y_PADDING:int = 16;
      
      private static const TANKNAME_DEFAULT_POSITION:int = -315;
      
      private static const TEXT_SIZE_WITH_LOW_SYMBOLS:int = 18;
      
      private static const DEFAULT_TEXT_SIZE_WITH_SYMBOLS:int = 16;
      
      private static const LOW_COUNT_SYMBOLS:int = 3;
      
      private static const TANKNAME_DELTA_Y:int = 2;
      
      private static const CIRCLE_DOWN_SCALE:Number = 0.72;
      
      private static const DAMAGE_FRAME_LABEL:String = "damage";
      
      private static const CRIT_FRAME_LABEL:String = "crit";
      
      private static const ENEMY_TANK_NAME_COLOR:uint = 16777215;
      
      private static const ALLY_TANK_NAME_COLOR:uint = 11206400;
      
      private static const TANK_NAME_ROTATION:int = -90;
      
      private static const BASE_CIRCLES:Vector.<String> = new <String>[DAMAGEINDICATOR.DAMAGE_CIRCLE,DAMAGEINDICATOR.DAMAGE_CIRCLE_BLIND,DAMAGEINDICATOR.BLOCK_CIRCLE];
      
      private static const CRIT_CIRCLES:Vector.<String> = new <String>[DAMAGEINDICATOR.CRIT_CIRCLE,DAMAGEINDICATOR.CRIT_CIRCLE_BLIND];
      
      private static const CRITS_ITEMS_CIRCLES:Vector.<String> = new <String>[DAMAGEINDICATOR.GUN_CIRCLE,DAMAGEINDICATOR.TRIPLEX_CIRCLE,DAMAGEINDICATOR.TRACKS_CIRCLE,DAMAGEINDICATOR.WHEEL_CIRCLE,DAMAGEINDICATOR.AMMO_CIRCLE,DAMAGEINDICATOR.COMMANDER_CIRCLE,DAMAGEINDICATOR.DRIVER_CIRCLE,DAMAGEINDICATOR.ENGINE_CIRCLE,DAMAGEINDICATOR.GUNNER_CIRCLE,DAMAGEINDICATOR.RADIO_CIRCLE,DAMAGEINDICATOR.RADIOMAN_CIRCLE,DAMAGEINDICATOR.RELOADER_CIRCLE,DAMAGEINDICATOR.TANKS_CIRCLE,DAMAGEINDICATOR.TURRET_CIRCLE];
      
      private static const TANK_TYPE_ICONS:Vector.<String> = new <String>[DAMAGEINDICATOR.HEAVY_TANK,DAMAGEINDICATOR.MEDIUM_TANK,DAMAGEINDICATOR.LIGHT_TANK,DAMAGEINDICATOR.AT_SPG,DAMAGEINDICATOR.SPG,DAMAGEINDICATOR.BUNKER_TURRET,DAMAGEINDICATOR.HEAVY_TANK_ELITE,DAMAGEINDICATOR.MEDIUM_TANK_ELITE,DAMAGEINDICATOR.LIGHT_TANK_ELITE,DAMAGEINDICATOR.AT_SPG_ELITE,DAMAGEINDICATOR.SPG_ELITE,DAMAGEINDICATOR.BOSS,DAMAGEINDICATOR.ALLY_HEAVY_TANK,DAMAGEINDICATOR.ALLY_MEDIUM_TANK,DAMAGEINDICATOR.ALLY_LIGHT_TANK,DAMAGEINDICATOR.ALLY_AT_SPG,DAMAGEINDICATOR.ALLY_SPG,DAMAGEINDICATOR.ALLY_HEAVY_TANK_ELITE,DAMAGEINDICATOR.ALLY_MEDIUM_TANK_ELITE,DAMAGEINDICATOR.ALLY_LIGHT_TANK_ELITE,DAMAGEINDICATOR.ALLY_AT_SPG_ELITE,DAMAGEINDICATOR.ALLY_SPG_ELITE,DAMAGEINDICATOR.ALLY_BOSS];
      
      private static const DAMAGE_TF_FRIENDLY_FIRE_Y_OFFSET:int = -2;
      
      private static const NODAMAGELABEL:String = "- -";
       
      
      public var offsetContainer:MovieClip = null;
      
      public var tankName:ItemWithRotation = null;
      
      public var tankNameTF:TextField = null;
      
      public var damageAnimContainer:MovieClip = null;
      
      public var circleAnimContainer:MovieClip = null;
      
      public var damage:ItemWithRotation = null;
      
      public var damageTF:TextField = null;
      
      public var tankIcon:Sprite = null;
      
      public var tankInfo:MovieClip = null;
      
      public var mainAnimContainer:MovieClip = null;
      
      private var _isFriendlyFire:Boolean = false;
      
      private var _tankTypeIconsMap:Dictionary = null;
      
      private var _circlesMap:Dictionary = null;
      
      private var _circleCritMap:Dictionary = null;
      
      private var _settingIsWithTankInfo:Boolean = true;
      
      private var _settingIsWithValue:Boolean = true;
      
      private var _circleCrit:Shape = null;
      
      private var _critIsVisible:Boolean = false;
      
      private var _currentCircle:Shape = null;
      
      private var _currentCircleStr:String;
      
      private var _currentTankIconStr:String;
      
      private var _currentTankIcon:Shape = null;
      
      private var _tankNameStr:String;
      
      private var _isBigTitle:Boolean = false;
      
      private var _tankNameTextFormat:TextFormat = null;
      
      private var _damageTextFormat:TextFormat = null;
      
      private var _damageTFdefaultY:int;
      
      private var _damageTFfriendlyFireY:int;
      
      public function ExtendedStateContainer()
      {
         super();
         this.offsetContainer.y = -240;
      }
      
      private static function setNewPosition(param1:Object, param2:int) : void
      {
         var _loc3_:Shape = null;
         for each(_loc3_ in param1)
         {
            _loc3_.y = -_loc3_.height + param2;
         }
      }
      
      override public final function dispose() : void
      {
         this.mainAnimContainer = null;
         this.offsetContainer = null;
         this.damageAnimContainer = null;
         this.circleAnimContainer = null;
         this._circleCrit = null;
         cleanupDynamicObject(this._tankTypeIconsMap);
         this._tankTypeIconsMap = null;
         cleanupDynamicObject(this._circlesMap);
         this._circlesMap = null;
         cleanupDynamicObject(this._circleCritMap);
         this._circleCritMap = null;
         this.tankNameTF = null;
         this.damageTF = null;
         this.tankIcon = null;
         this._currentTankIcon = null;
         this.tankName.dispose();
         this.tankName = null;
         this.damage.dispose();
         this.damage = null;
         this.tankInfo = null;
         this._tankNameTextFormat = null;
         this._damageTextFormat = null;
         this._currentCircle = null;
         super.dispose();
      }
      
      override public function init() : void
      {
         super.init();
         this.tankInfo = this.offsetContainer.tankInfo;
         this.circleAnimContainer = this.offsetContainer.circleAnimContainer;
         this.mainAnimContainer = this.offsetContainer.mainAnimContainer;
         this.tankName = this.tankInfo.tankName;
         this.tankIcon = this.tankInfo.tankIcon;
         this.tankNameTF = this.tankName.textField;
         this.damage = this.circleAnimContainer.damage;
         this.damageTF = this.damage.textField;
         this._damageTFdefaultY = this.damageTF.y;
         this._damageTFfriendlyFireY = this._damageTFdefaultY + DAMAGE_TF_FRIENDLY_FIRE_Y_OFFSET;
         this._tankTypeIconsMap = createItemsFromAtlas(TANK_TYPE_ICONS,this.tankIcon,null);
         this._circlesMap = createItemsFromAtlas(BASE_CIRCLES,this.damage,null);
         this._circlesMap = createItemsFromAtlas(CRITS_ITEMS_CIRCLES,this.damage,this._circlesMap);
         this._circleCritMap = createItemsFromAtlas(CRIT_CIRCLES,this.damage,null);
         this.applyCircleScale();
         statesBG = createItemsFromAtlas(this.stateNames,this.mainAnimContainer,null);
         currentState = statesBG[DAMAGEINDICATOR.DAMAGE_SMALL];
         this._currentTankIcon = this._tankTypeIconsMap[DAMAGEINDICATOR.LIGHT_TANK];
         this._currentCircle = this._circlesMap[DAMAGEINDICATOR.GUN_CIRCLE];
         this._circleCrit = this._circleCritMap[DAMAGEINDICATOR.CRIT_CIRCLE_BLIND];
         this.tankNameTF.autoSize = TextFieldAutoSize.CENTER;
         this.damageTF.autoSize = TextFieldAutoSize.CENTER;
         TextFieldEx.setVerticalAlign(this.tankNameTF,TextFieldEx.VALIGN_CENTER);
         TextFieldEx.setVerticalAlign(this.damageTF,TextFieldEx.VALIGN_CENTER);
         this._damageTextFormat = this.damageTF.getTextFormat();
         this._tankNameTextFormat = this.tankNameTF.getTextFormat();
      }
      
      override public function rotateInfo(param1:Number) : void
      {
         super.rotateInfo(param1);
         this.damage.rotation = -param1;
         this.tankName.rotation = this.tankIcon.rotation = param1 < 0 ? Number(-TANK_NAME_ROTATION) : Number(TANK_NAME_ROTATION);
      }
      
      override protected function updatePosition() : void
      {
         this.offsetContainer.y = offsetY;
         setNewPosition(this._tankTypeIconsMap,TANK_ICON_Y_PADDING);
      }
      
      public function setExtendedData(param1:String, param2:String, param3:String, param4:String, param5:String, param6:Boolean, param7:Boolean = true) : void
      {
         var _loc10_:Boolean = false;
         var _loc8_:Boolean = param1 == DAMAGEINDICATOR.CRIT || param1 == DAMAGEINDICATOR.CRIT_BLIND;
         updateBGState(param1);
         this._circleCrit.visible = false;
         if(param1 == DAMAGEINDICATOR.CRIT)
         {
            this._circleCrit = this._circleCritMap[DAMAGEINDICATOR.CRIT_CIRCLE];
         }
         else if(param1 == DAMAGEINDICATOR.CRIT_BLIND)
         {
            this._circleCrit = this._circleCritMap[DAMAGEINDICATOR.CRIT_CIRCLE_BLIND];
         }
         if(this._settingIsWithTankInfo)
         {
            if(this._currentTankIconStr != param4)
            {
               this._currentTankIcon.visible = false;
               if(param4 != Values.EMPTY_STR)
               {
                  this._currentTankIconStr = param4;
                  this._currentTankIcon = this._tankTypeIconsMap[param4];
                  this._currentTankIcon.visible = true;
               }
            }
            if(this._tankNameStr != param3)
            {
               this._tankNameStr = param3;
               this.tankNameTF.text = param3;
               this.tankNameTF.y = -this.tankNameTF.height - TANKNAME_DELTA_Y >> 1;
               this.tankName.y = TANKNAME_DEFAULT_POSITION - (this.tankNameTF.textWidth >> 1);
            }
            if(param6 != this._isFriendlyFire)
            {
               this._isFriendlyFire = param6;
               this._tankNameTextFormat.color = !!param6 ? ALLY_TANK_NAME_COLOR : ENEMY_TANK_NAME_COLOR;
               this.tankNameTF.setTextFormat(this._tankNameTextFormat);
            }
         }
         if(this._settingIsWithValue)
         {
            if(this._currentCircleStr != param2)
            {
               this._currentCircleStr = param2;
               this._currentCircle.visible = false;
               if(this._currentCircleStr != DAMAGEINDICATOR.CRIT_CIRCLE && this._currentCircleStr != DAMAGEINDICATOR.CRIT_CIRCLE_BLIND)
               {
                  this._currentCircle = this._circlesMap[this._currentCircleStr];
                  this._currentCircle.visible = true;
               }
            }
            if(_loc8_)
            {
               this._circleCrit.visible = this._critIsVisible = true;
            }
            else if(this._critIsVisible)
            {
               this._circleCrit.visible = this._critIsVisible = false;
            }
            _loc10_ = param5.length > LOW_COUNT_SYMBOLS;
            if(this._isBigTitle != _loc10_)
            {
               this._isBigTitle = _loc10_;
               this._damageTextFormat.size = !!this._isBigTitle ? TEXT_SIZE_WITH_LOW_SYMBOLS : DEFAULT_TEXT_SIZE_WITH_SYMBOLS;
               this.damageTF.setTextFormat(this._damageTextFormat);
            }
            this.damageTF.text = param5;
            if(param6 && param5 == NODAMAGELABEL)
            {
               this.damageTF.y = this._damageTFfriendlyFireY;
            }
            else
            {
               this.damageTF.y = this._damageTFdefaultY;
            }
         }
         var _loc9_:String = !!_loc8_ ? CRIT_FRAME_LABEL : DAMAGE_FRAME_LABEL;
         if(param7)
         {
            this.offsetContainer.gotoAndPlay(_loc9_);
         }
         else
         {
            this.offsetContainer.gotoAndStop(_loc9_);
         }
      }
      
      public function updateSettings(param1:Boolean, param2:Boolean) : void
      {
         if(param1 != this._settingIsWithTankInfo)
         {
            this._settingIsWithTankInfo = param1;
            this.tankName.visible = this._settingIsWithTankInfo;
            this.tankIcon.visible = this._settingIsWithTankInfo;
            this._currentTankIcon.visible = this._settingIsWithTankInfo;
         }
         if(param2 != this._settingIsWithValue)
         {
            this._settingIsWithValue = param2;
            this.circleAnimContainer.visible = this._settingIsWithValue;
            this._currentCircle.visible = this._settingIsWithValue;
         }
      }
      
      private function applyCircleScale() : void
      {
         var _loc1_:Shape = null;
         for each(_loc1_ in this._circlesMap)
         {
            _loc1_.scaleX = _loc1_.scaleY = CIRCLE_DOWN_SCALE;
         }
      }
      
      override protected function get stateNames() : Vector.<String>
      {
         return new <String>[DAMAGEINDICATOR.DAMAGE_SMALL,DAMAGEINDICATOR.DAMAGE_MEDIUM,DAMAGEINDICATOR.DAMAGE_BIG,DAMAGEINDICATOR.DAMAGE_SMALL_BLIND,DAMAGEINDICATOR.DAMAGE_MEDIUM_BLIND,DAMAGEINDICATOR.DAMAGE_BIG_BLIND,DAMAGEINDICATOR.BLOCKED_SMALL,DAMAGEINDICATOR.BLOCKED_MEDIUM,DAMAGEINDICATOR.BLOCKED_BIG,DAMAGEINDICATOR.CRIT,DAMAGEINDICATOR.CRIT_BLIND];
      }
   }
}
