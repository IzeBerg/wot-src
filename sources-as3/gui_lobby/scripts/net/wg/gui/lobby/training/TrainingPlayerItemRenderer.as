package net.wg.gui.lobby.training
{
   import flash.text.TextField;
   import net.wg.data.VO.TrainingRoomRendererVO;
   import net.wg.data.constants.Values;
   import scaleform.clik.utils.Constraints;
   
   public class TrainingPlayerItemRenderer extends TrainingPlayerItemRendererBase
   {
       
      
      public var stateField:TextField;
      
      public function TrainingPlayerItemRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(!constraintsDisabled)
         {
            constraints.addElement(this.stateField.name,this.stateField,Constraints.RIGHT);
         }
      }
      
      override protected function onDispose() : void
      {
         this.stateField = null;
         super.onDispose();
      }
      
      override protected function doUpdateData(param1:TrainingRoomRendererVO) : void
      {
         super.doUpdateData(param1);
         this.stateField.text = param1.stateString;
      }
      
      override protected function resetData() : void
      {
         super.resetData();
         if(this.stateField)
         {
            this.stateField.text = Values.EMPTY_STR;
         }
      }
   }
}
