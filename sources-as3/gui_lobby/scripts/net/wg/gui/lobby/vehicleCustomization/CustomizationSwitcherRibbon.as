package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.infrastructure.managers.ISoundManager;
   import net.wg.infrastructure.managers.ITooltipMgr;
   
   public class CustomizationSwitcherRibbon extends CustomizationFadeInFadeOutMovieClip
   {
       
      
      public var hit:Sprite = null;
      
      public var glow:Sprite = null;
      
      private var _tooltipEnabled:Boolean = false;
      
      private var _tooltip:String = "";
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _soundMgr:ISoundManager;
      
      public function CustomizationSwitcherRibbon()
      {
         this._tooltipMgr = App.toolTipMgr;
         this._soundMgr = App.soundMgr;
         super();
      }
      
      public function initialize() : void
      {
         mouseChildren = mouseEnabled = true;
         var _loc1_:Sprite = new Sprite();
         addChild(_loc1_);
         this.glow.hitArea = _loc1_;
         this.hit.addEventListener(MouseEvent.ROLL_OVER,this.onMouseOverHandler);
         this.hit.addEventListener(MouseEvent.ROLL_OUT,this.onMouseOutHandler);
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         if(this._tooltipEnabled)
         {
            this._soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.CUSTOMIZATION_DEFAULT,null);
            this._tooltipMgr.show(this._tooltip);
         }
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      override protected function onDispose() : void
      {
         this.hit.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseOverHandler);
         this.hit.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseOutHandler);
         this.hit = null;
         this.glow = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      public function get tooltipEnabled() : Boolean
      {
         return this._tooltipEnabled;
      }
      
      public function set tooltipEnabled(param1:Boolean) : void
      {
         this._tooltipEnabled = param1;
      }
      
      public function get tooltip() : String
      {
         return this._tooltip;
      }
      
      public function set tooltip(param1:String) : void
      {
         this._tooltip = param1;
      }
   }
}
