package net.wg.gui.lobby.training
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.infrastructure.managers.ITooltipMgr;
   
   public class Comp7Conditions extends AdditionalInfoContent
   {
      
      private static const SEPARATOR_OFFSET_X:uint = 5;
      
      private static const TEXT_OFFSET_X:uint = 2;
       
      
      public var freeConsumablesTf:TextField;
      
      public var tierTf:TextField;
      
      public var tierIcon:Sprite;
      
      public var separatorIcon:Sprite;
      
      public var freeConsumablesIcon:Sprite;
      
      private var _currentLayout:uint = 0;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _separatorIconOriginalX:int = 0;
      
      private var _freeConsumablesIconOriginalX:int = 0;
      
      public function Comp7Conditions()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
         this.initialize();
      }
      
      override public function setLayout(param1:uint) : void
      {
         if(this._currentLayout == param1)
         {
            return;
         }
         this._currentLayout = param1;
         this.freeConsumablesTf.visible = this.tierTf.visible = this._currentLayout != LAYOUT_SMALL;
         if(this._currentLayout == LAYOUT_SMALL_WITH_TEXT_AND_SEPARATOR)
         {
            this.tierTf.x = this.tierIcon.width + TEXT_OFFSET_X | 0;
            this.separatorIcon.x = this.tierTf.x + this.tierTf.textWidth + TEXT_OFFSET_X + SEPARATOR_OFFSET_X + SEPARATOR_OFFSET_X | 0;
            this.freeConsumablesIcon.x = this.separatorIcon.x + TEXT_OFFSET_X + SEPARATOR_OFFSET_X | 0;
            this.freeConsumablesTf.x = this.freeConsumablesIcon.x + this.freeConsumablesIcon.width + TEXT_OFFSET_X | 0;
         }
         else if(this._currentLayout == LAYOUT_BIG)
         {
            this.tierTf.x = this.tierIcon.width;
            this.separatorIcon.x = this.tierTf.x + this.tierTf.textWidth + TEXT_OFFSET_X + SEPARATOR_OFFSET_X + SEPARATOR_OFFSET_X | 0;
            this.freeConsumablesIcon.x = this.separatorIcon.x + TEXT_OFFSET_X + SEPARATOR_OFFSET_X | 0;
            this.freeConsumablesTf.x = this.freeConsumablesIcon.x + this.freeConsumablesIcon.width | 0;
         }
         else
         {
            this.separatorIcon.x = this._separatorIconOriginalX;
            this.freeConsumablesIcon.x = this._freeConsumablesIconOriginalX;
         }
      }
      
      override protected function onDispose() : void
      {
         this.freeConsumablesIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.freeConsumablesIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.freeConsumablesTf.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.freeConsumablesTf.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.freeConsumablesTf = null;
         this.tierTf = null;
         this.tierIcon = null;
         this.separatorIcon = null;
         this.freeConsumablesIcon = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      protected function initialize() : void
      {
         this.freeConsumablesTf.text = MENU.TRAINING_NOTIFICATIONTEXT_FREESUPPLIES;
         this.tierTf.text = MENU.TRAINING_NOTIFICATIONTEXT_ONLYTIERX;
         App.utils.commons.updateTextFieldSize(this.freeConsumablesTf,true,true);
         App.utils.commons.updateTextFieldSize(this.tierTf,true,true);
         this.freeConsumablesTf.visible = this.tierTf.visible = false;
         this._separatorIconOriginalX = this.separatorIcon.x;
         this._freeConsumablesIconOriginalX = this.freeConsumablesIcon.x;
         this.freeConsumablesIcon.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.freeConsumablesIcon.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.freeConsumablesTf.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.freeConsumablesTf.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.show(MENU.TRAINING_ADDITIONALINFO_FREESUPPLIESCOMP7);
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
