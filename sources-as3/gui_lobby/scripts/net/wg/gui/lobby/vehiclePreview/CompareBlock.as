package net.wg.gui.lobby.vehiclePreview
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.vehicleCompare.events.VehCompareEvent;
   import net.wg.gui.lobby.vehiclePreview.data.VPPageVO;
   import net.wg.infrastructure.base.UIComponentEx;
   
   [Event(name="addToCompare",type="net.wg.gui.lobby.vehicleCompare.events.VehCompareEvent")]
   public class CompareBlock extends UIComponentEx
   {
      
      private static const COMPARE_BUTTON_H_OFFSET:int = 13;
      
      private static const COMPARE_FIELD_H_OFFSET:int = 5;
       
      
      public var toComparisonTF:TextField;
      
      public var addToCompareButton:SoundButtonEx;
      
      public function CompareBlock()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.toComparisonTF.mouseEnabled = this.toComparisonTF.mouseWheelEnabled = false;
         this.toComparisonTF.autoSize = TextFieldAutoSize.LEFT;
         this.toComparisonTF.wordWrap = false;
         this.toComparisonTF.text = MENU.RESEARCH_LABELS_BUTTON_ADDTOCOMPARE;
         this.addToCompareButton.mouseEnabledOnDisabled = true;
         this.addToCompareButton.x = this.toComparisonTF.width - COMPARE_BUTTON_H_OFFSET + COMPARE_FIELD_H_OFFSET >> 0;
         addEventListener(MouseEvent.CLICK,this.onClickHandler);
         hitArea.x = this.toComparisonTF.x;
         hitArea.width = this.addToCompareButton.x + this.addToCompareButton.width - COMPARE_BUTTON_H_OFFSET;
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.addToCompareButton.dispose();
         this.addToCompareButton = null;
         this.toComparisonTF = null;
         super.onDispose();
      }
      
      public function setData(param1:VPPageVO) : void
      {
         this.addToCompareButton.tooltip = param1.compareBtnTooltip;
         this.addToCompareButton.enabled = param1.showCompareBtn;
         buttonMode = param1.showCompareBtn;
         this.toComparisonTF.alpha = !!param1.showCompareBtn ? Number(1) : Number(0.5);
      }
      
      override public function get width() : Number
      {
         return this.addToCompareButton.x + this.addToCompareButton.width - COMPARE_BUTTON_H_OFFSET;
      }
      
      override public function get height() : Number
      {
         return this.toComparisonTF.height;
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         if(!this.addToCompareButton.enabled)
         {
            return;
         }
         dispatchEvent(new VehCompareEvent(VehCompareEvent.ADD));
      }
   }
}
