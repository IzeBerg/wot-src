package net.wg.gui.lobby.settings.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.settings.components.evnts.LimitedUIEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.events.ButtonEvent;
   
   public class LimitedUISettingBlock extends UIComponentEx
   {
      
      private static const INFO_ICON_X_PADDING:int = 10;
      
      private static const MAX_TOOLTIP_WIDTH:uint = 270;
       
      
      public var descTf:TextField = null;
      
      public var infoIcon:InfoIcon = null;
      
      public var turnOffBtn:SoundButtonEx = null;
      
      public var lip:MovieClip = null;
      
      public function LimitedUISettingBlock()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.descTf.autoSize = TextFieldAutoSize.CENTER;
         this.descTf.text = SETTINGS.LIMITEDUI_DESC;
         this.infoIcon.icoType = InfoIcon.TYPE_WARNING;
         this.infoIcon.tooltip = TOOLTIPS.LIMITEDUISETTINGBLOCK_INFO;
         this.infoIcon.tooltipMaxWidth = MAX_TOOLTIP_WIDTH;
         this.infoIcon.x = this.descTf.x + this.descTf.textWidth + INFO_ICON_X_PADDING;
         this.turnOffBtn.label = SETTINGS.LIMITEDUI_TURNOFFBTN;
         this.turnOffBtn.addEventListener(ButtonEvent.CLICK,this.turnOffBtnClickHandler,false,0,true);
         this.lip.mouseChildren = this.lip.mouseEnabled = false;
         mouseEnabled = false;
      }
      
      override protected function onDispose() : void
      {
         this.descTf = null;
         this.infoIcon.dispose();
         this.infoIcon = null;
         this.turnOffBtn.removeEventListener(ButtonEvent.CLICK,this.turnOffBtnClickHandler);
         this.turnOffBtn.dispose();
         this.turnOffBtn = null;
         this.lip = null;
         super.onDispose();
      }
      
      private function turnOffBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new LimitedUIEvent(LimitedUIEvent.TURN_OFF,true));
      }
   }
}
