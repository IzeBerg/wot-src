package net.wg.gui.lobby.missions.components
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Fonts;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.gui.lobby.missions.event.MissionViewEvent;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import scaleform.clik.events.ButtonEvent;
   
   public class RtsMissionsBanner extends BaseDAAPIComponent
   {
      
      private static const BTN_HORIZONTAL_PADDING:int = 20;
      
      private static const BTN_Y_GAP:int = 10;
       
      
      public var gotoBtn:UniversalBtn = null;
      
      public var messageTF:TextField = null;
      
      public var bg:MovieClip = null;
      
      private var _currentHeight:int = 196;
      
      public function RtsMissionsBanner()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.messageTF.autoSize = TextFieldAutoSize.CENTER;
         this.messageTF.text = RTS_BATTLES.COMBATMISSIONS_MESSAGE;
         this.gotoBtn.addEventListener(Event.RESIZE,this.onGotoButtonResizeHandler);
         this.gotoBtn.addEventListener(ButtonEvent.CLICK,this.onGotoBtnClickHandler);
         this.gotoBtn.currentFont = Fonts.FIELD_FONT;
         this.gotoBtn.paddingHorizontal = BTN_HORIZONTAL_PADDING;
         this.gotoBtn.dynamicSizeByText = true;
         this.gotoBtn.label = RTS_BATTLES.COMBATMISSIONS_GOTOBUTTON;
         this.gotoBtn.iconSource = RES_ICONS.MAPS_ICONS_RTSBATTLES_ICON_BATTLE_MISSIONS;
         App.utils.universalBtnStyles.setStyle(this.gotoBtn,UniversalBtnStylesConst.STYLE_HEAVY_RTS_TRANSPARENT);
         this.gotoBtn.validateNow();
      }
      
      override protected function onDispose() : void
      {
         this.gotoBtn.removeEventListener(Event.RESIZE,this.onGotoButtonResizeHandler);
         this.gotoBtn.removeEventListener(ButtonEvent.CLICK,this.onGotoBtnClickHandler);
         this.gotoBtn.dispose();
         this.gotoBtn = null;
         this.messageTF = null;
         this.bg = null;
         super.onDispose();
      }
      
      private function onGotoButtonResizeHandler(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         this.gotoBtn.x = width - this.gotoBtn.width >> 1;
         this.gotoBtn.y = this.messageTF.y + this.messageTF.height + BTN_Y_GAP | 0;
         this._currentHeight = this.gotoBtn.y + this.gotoBtn.height;
      }
      
      private function onGotoBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new MissionViewEvent(MissionViewEvent.RTS_BANNER_GOTO_MISSIONS,true));
      }
      
      override public function get height() : Number
      {
         return this._currentHeight;
      }
   }
}
