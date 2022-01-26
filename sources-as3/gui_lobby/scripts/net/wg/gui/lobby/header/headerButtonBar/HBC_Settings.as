package net.wg.gui.lobby.header.headerButtonBar
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.gui.components.controls.helpers.ServerPingState;
   import net.wg.gui.lobby.header.vo.HBC_SettingsVo;
   import scaleform.clik.utils.Padding;
   
   public class HBC_Settings extends HeaderButtonContentItem
   {
      
      private static const START_X_POS:int = 4;
      
      private static const PING_STATUS_START_NAME:String = "pingStatus";
      
      private static const COLOR_BLIND_NAME:String = "ColorBlind";
      
      private static const BLINK_LABEL:String = "show";
       
      
      public var icon:Sprite;
      
      public var pingStatus0:Sprite;
      
      public var pingStatus1:Sprite;
      
      public var pingStatus2:Sprite;
      
      public var pingStatus3:Sprite;
      
      public var pingStatus1ColorBlind:Sprite;
      
      public var blink:MovieClip;
      
      private var _pingStatuses:Vector.<Sprite>;
      
      private var _settingsDataVo:HBC_SettingsVo = null;
      
      private var _minScreenPaddingIfTextMoreIco:Padding;
      
      public function HBC_Settings()
      {
         this._minScreenPaddingIfTextMoreIco = new Padding(0,6,0,6);
         super();
         this._pingStatuses = Vector.<Sprite>([this.pingStatus0,this.pingStatus1,this.pingStatus2,this.pingStatus3,this.pingStatus1ColorBlind]);
         minScreenPadding.left = 1;
         minScreenPadding.right = 1;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         minScreenPadding = this._minScreenPaddingIfTextMoreIco;
         this.showPingStatus(ServerPingState.UNDEFINED,false);
      }
      
      override protected function onDispose() : void
      {
         this.icon = null;
         this.pingStatus0 = null;
         this.pingStatus1 = null;
         this.pingStatus2 = null;
         this.pingStatus3 = null;
         this.blink = null;
         this.pingStatus1ColorBlind = null;
         this._pingStatuses.splice(0,this._pingStatuses.length);
         this._pingStatuses = null;
         this._settingsDataVo = null;
         this._minScreenPaddingIfTextMoreIco = null;
         super.onDispose();
      }
      
      override protected function updateSize() : void
      {
         bounds.width = this.icon.x + this.icon.width;
         super.updateSize();
      }
      
      override protected function updateData() : void
      {
         if(data != null)
         {
            this.showPingStatus(this._settingsDataVo.pingStatus,this._settingsDataVo.isColorBlind);
         }
         super.updateData();
      }
      
      private function showPingStatus(param1:int, param2:Boolean) : void
      {
         var _loc4_:Sprite = null;
         var _loc3_:String = "";
         if(param2 && param1 == ServerPingState.HIGH)
         {
            _loc3_ = COLOR_BLIND_NAME;
         }
         var _loc5_:int = this._pingStatuses.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = this._pingStatuses[_loc6_];
            _loc4_.visible = _loc4_.name == PING_STATUS_START_NAME + param1 + _loc3_;
            _loc6_++;
         }
      }
      
      override protected function get leftPadding() : Number
      {
         return 0;
      }
      
      override protected function get rightPadding() : Number
      {
         return START_X_POS;
      }
      
      override public function set data(param1:Object) : void
      {
         this._settingsDataVo = HBC_SettingsVo(param1);
         super.data = param1;
      }
      
      public function showBlink() : void
      {
         this.blink.gotoAndPlay(BLINK_LABEL);
      }
   }
}
