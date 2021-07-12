package net.wg.gui.prebattle.battleSession
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.TextFieldShort;
   import scaleform.clik.utils.Constraints;
   
   public class BattleSessionListRenderer extends TextFieldShort
   {
      
      private static const INVALIDATE_DATA:String = "invalidateData";
       
      
      public var opponentsField:TextField;
      
      public var timeField:TextField;
      
      private var dataVO:BSListRendererVO = null;
      
      public var icon:MovieClip;
      
      public function BattleSessionListRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.shadowColor = "Black";
         this.textColor = 16777215;
         this.textSize = 15;
         constraints.addElement("opponentsField",this.opponentsField,Constraints.ALL);
         constraints.addElement("timeField",this.timeField,Constraints.ALL);
         constraints.addElement(this.icon.name,this.icon,Constraints.LEFT | Constraints.TOP);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALIDATE_DATA) && this.dataVO)
         {
            this.afterSetData();
         }
      }
      
      private function afterSetData() : void
      {
         textField.text = this.dataVO.descr;
         this.opponentsField.text = this.dataVO.opponents;
         this.timeField.text = this.dataVO.startTime;
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this.dataVO = BSListRendererVO(param1);
         visible = this.dataVO != null;
         if(visible)
         {
            label = this.dataVO.descr;
            invalidate(INVALIDATE_DATA);
            validateNow();
         }
      }
   }
}
