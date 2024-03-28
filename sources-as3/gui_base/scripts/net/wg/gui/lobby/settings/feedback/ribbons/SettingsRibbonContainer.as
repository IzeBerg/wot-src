package net.wg.gui.lobby.settings.feedback.ribbons
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.VehicleTypes;
   import net.wg.data.constants.generated.BATTLE_EFFICIENCY_TYPES;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.ribbon.data.RibbonSettingsLobby;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.settings.feedback.ribbons.data.RibbonItemData;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   
   public class SettingsRibbonContainer extends UIComponentEx
   {
      
      private static const E100:String = "#germany_vehicles:E-100";
      
      private static const ITEM_STEP_Y:int = 30;
      
      private static const ALERT_ICON_PADDING_Y:int = 6;
      
      private static const TEXT_FIELD_ADDITIONAL_HEIGHT:int = 4;
      
      private static const RIBBONS_HEIGHT_OFFSET:int = 50;
       
      
      public var alertIcon:UILoaderAlt = null;
      
      public var info:TextField = null;
      
      public var infoBG:MovieClip = null;
      
      public var hintArea:MovieClip = null;
      
      private var _map:Dictionary = null;
      
      private var _itemsData:Vector.<RibbonItemData> = null;
      
      private var _colorMgr:IColorSchemeManager = null;
      
      private var _ribbonsContainer:Sprite;
      
      public function SettingsRibbonContainer()
      {
         var _loc2_:SettingsRibbonItem = null;
         var _loc3_:RibbonItemData = null;
         var _loc5_:RibbonSettingsLobby = null;
         super();
         this._ribbonsContainer = new Sprite();
         this.addChild(this._ribbonsContainer);
         this._itemsData = new <RibbonItemData>[new RibbonItemData(BATTLE_EFFICIENCY_TYPES.RECEIVED_DAMAGE,SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_RECEIVEDDAMAGE,SETTINGS.FEEDBACK_TAB_RIBBONS_DAMAGEVALUE,E100,VehicleTypes.HEAVY_TANK),new RibbonItemData(BATTLE_EFFICIENCY_TYPES.RECEIVED_CRITS,INGAME_GUI.EFFICIENCYRIBBONS_RECEIVEDCRITS,SETTINGS.FEEDBACK_TAB_RIBBONS_CRITVALUE,E100,VehicleTypes.HEAVY_TANK),new RibbonItemData(BATTLE_EFFICIENCY_TYPES.ARMOR,INGAME_GUI.EFFICIENCYRIBBONS_ARMOR,SETTINGS.FEEDBACK_TAB_RIBBONS_ARMORVALUE,E100,VehicleTypes.HEAVY_TANK),new RibbonItemData(BATTLE_EFFICIENCY_TYPES.DEFENCE,INGAME_GUI.EFFICIENCYRIBBONS_DEFENCE,SETTINGS.FEEDBACK_TAB_RIBBONS_DEFENCEVALUE),new RibbonItemData(BATTLE_EFFICIENCY_TYPES.CAPTURE,INGAME_GUI.EFFICIENCYRIBBONS_CAPTURE,SETTINGS.FEEDBACK_TAB_RIBBONS_CAPTUREVALUE),new RibbonItemData(BATTLE_EFFICIENCY_TYPES.DETECTION,INGAME_GUI.EFFICIENCYRIBBONS_SPOTTED,Values.EMPTY_STR),new RibbonItemData(BATTLE_EFFICIENCY_TYPES.RAM,INGAME_GUI.EFFICIENCYRIBBONS_RAM,SETTINGS.FEEDBACK_TAB_RIBBONS_RAMVALUE,E100,VehicleTypes.HEAVY_TANK),new RibbonItemData(BATTLE_EFFICIENCY_TYPES.DESTRUCTION,INGAME_GUI.EFFICIENCYRIBBONS_KILL,Values.EMPTY_STR,E100,VehicleTypes.HEAVY_TANK),new RibbonItemData(BATTLE_EFFICIENCY_TYPES.ASSIST_TRACK,INGAME_GUI.EFFICIENCYRIBBONS_ASSISTTRACK,SETTINGS.FEEDBACK_TAB_RIBBONS_ASSISTTRACKVALUE,E100,VehicleTypes.HEAVY_TANK),new RibbonItemData(BATTLE_EFFICIENCY_TYPES.CRITS,INGAME_GUI.EFFICIENCYRIBBONS_CRITS,Values.EMPTY_STR,E100,VehicleTypes.HEAVY_TANK),new RibbonItemData(BATTLE_EFFICIENCY_TYPES.DAMAGE,INGAME_GUI.EFFICIENCYRIBBONS_DAMAGE,SETTINGS.FEEDBACK_TAB_RIBBONS_DAMAGEVALUE,E100,VehicleTypes.HEAVY_TANK),new RibbonItemData(BATTLE_EFFICIENCY_TYPES.WORLD_COLLISION,INGAME_GUI.EFFICIENCYRIBBONS_WORLDCOLLISION,SETTINGS.FEEDBACK_TAB_RIBBONS_DAMAGEVALUE,E100,VehicleTypes.HEAVY_TANK),new RibbonItemData(BATTLE_EFFICIENCY_TYPES.ASSIST_SPOT,INGAME_GUI.EFFICIENCYRIBBONS_ASSISTSPOT,SETTINGS.FEEDBACK_TAB_RIBBONS_ASSISTSPOTVALUE,E100,VehicleTypes.HEAVY_TANK),new RibbonItemData(BATTLE_EFFICIENCY_TYPES.ASSIST_STUN,INGAME_GUI.EFFICIENCYRIBBONS_ASSISTSTUN,SETTINGS.FEEDBACK_TAB_RIBBONS_ASSISTSTUN,E100,VehicleTypes.HEAVY_TANK),new RibbonItemData(BATTLE_EFFICIENCY_TYPES.BURN,INGAME_GUI.EFFICIENCYRIBBONS_BURN,SETTINGS.FEEDBACK_TAB_RIBBONS_BURNVALUE,E100,VehicleTypes.HEAVY_TANK),new RibbonItemData(BATTLE_EFFICIENCY_TYPES.STUN,INGAME_GUI.EFFICIENCYRIBBONS_STUN,SETTINGS.FEEDBACK_TAB_RIBBONS_STUN)];
         this._colorMgr = App.colorSchemeMgr;
         this._colorMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorMgrSchemasUpdateHandler);
         this._map = new Dictionary();
         var _loc1_:int = this._itemsData.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc1_)
         {
            _loc3_ = this._itemsData[_loc4_];
            _loc5_ = new RibbonSettingsLobby(_loc3_.ribbonType,_loc3_.text);
            _loc2_ = new SettingsRibbonItem(_loc5_);
            this._ribbonsContainer.addChild(_loc2_);
            _loc2_.y = ITEM_STEP_Y * _loc4_;
            _loc2_.setData(_loc3_.vehType,_loc3_.vehName,_loc3_.value);
            this._map[_loc3_.ribbonType] = _loc2_;
            _loc4_++;
         }
         this.info.text = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_INFO;
         this.info.height = this.info.textHeight + TEXT_FIELD_ADDITIONAL_HEIGHT;
         this.infoBG.y = Math.round(this.info.y - (this.infoBG.height - this.info.height) / 2);
         this.alertIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_ATTENTIONICONFILLEDBIG;
         this.alertIcon.addEventListener(UILoaderEvent.COMPLETE,this.onAlertIconCompleteHandler);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         this._colorMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorMgrSchemasUpdateHandler);
         this._colorMgr = null;
         this._itemsData.splice(0,this._itemsData.length);
         this._itemsData = null;
         for each(_loc1_ in this._map)
         {
            _loc1_.dispose();
         }
         App.utils.data.cleanupDynamicObject(this._map);
         this._map = null;
         this.info = null;
         this.infoBG = null;
         this.hintArea = null;
         this.alertIcon.removeEventListener(UILoaderEvent.COMPLETE,this.onAlertIconCompleteHandler);
         this.alertIcon.dispose();
         this.alertIcon = null;
         super.onDispose();
      }
      
      public function redraw() : void
      {
         var _loc3_:String = null;
         var _loc4_:SettingsRibbonItem = null;
         var _loc1_:int = this._itemsData.length;
         var _loc2_:int = 0;
         var _loc5_:Vector.<SettingsRibbonItem> = new Vector.<SettingsRibbonItem>(0);
         var _loc6_:int = 0;
         while(_loc6_ < _loc1_)
         {
            _loc3_ = this._itemsData[_loc6_].ribbonType;
            _loc4_ = this._map[_loc3_];
            if(_loc4_.parent)
            {
               _loc4_.y = _loc2_ * ITEM_STEP_Y;
               _loc5_.push(_loc4_);
               _loc2_++;
            }
            _loc6_++;
         }
         if(this._ribbonsContainer.height > 440)
         {
            this._ribbonsContainer.y = 0;
            this.hintArea.y = this._ribbonsContainer.height - this.hintArea.height - 15;
         }
         else
         {
            this.hintArea.y = 339;
            this._ribbonsContainer.y = this.hintArea.y + this.hintArea.height - this._ribbonsContainer.height + 15;
         }
         this.updateInfoBlockPosition();
         this.alertIcon.visible = this.hintArea.visible = this.info.visible = this.infoBG.visible = _loc2_ > 0;
         var _loc7_:Number = actualHeight - (_loc2_ > 0 ? RIBBONS_HEIGHT_OFFSET : 0);
         setSize(actualWidth,_loc7_);
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      public function updateItemVisible(param1:String, param2:Boolean) : void
      {
         var _loc3_:SettingsRibbonItem = this._map[param1];
         if(param2)
         {
            if(!_loc3_.parent)
            {
               this._ribbonsContainer.addChild(_loc3_);
            }
         }
         else if(_loc3_.parent)
         {
            this._ribbonsContainer.removeChild(_loc3_);
         }
      }
      
      public function updateSettings(param1:Boolean, param2:Boolean) : void
      {
         var _loc4_:SettingsRibbonItem = null;
         var _loc5_:String = null;
         var _loc3_:int = this._itemsData.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = this._itemsData[_loc6_].ribbonType;
            _loc4_ = this._map[_loc5_];
            _loc4_.updateSettings(param1,param2);
            _loc6_++;
         }
      }
      
      private function updateInfoBlockPosition() : void
      {
         var _loc1_:int = this.alertIcon.height + ALERT_ICON_PADDING_Y + this.info.textHeight >> 1;
         this.alertIcon.y = Math.round(this.hintArea.y + this.hintArea.height / 2 - _loc1_);
         this.info.y = this.alertIcon.y + this.alertIcon.height + ALERT_ICON_PADDING_Y;
         this.infoBG.y = Math.round(this.info.y - (this.infoBG.height - this.info.height) / 2);
      }
      
      private function onColorMgrSchemasUpdateHandler(param1:ColorSchemeEvent) : void
      {
         var _loc3_:SettingsRibbonItem = null;
         var _loc2_:int = this._itemsData.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this._map[this._itemsData[_loc4_].ribbonType];
            _loc3_.update();
            _loc4_++;
         }
      }
      
      private function onAlertIconCompleteHandler(param1:Event) : void
      {
         this.updateInfoBlockPosition();
      }
   }
}
