package net.wg.gui.lobby.training
{
   import flash.text.TextField;
   import net.wg.data.VO.TrainingRoomRendererVO;
   import net.wg.data.constants.Values;
   
   public class DragPlayerElement extends DragPlayerElementBase
   {
       
      
      public var stateField:TextField = null;
      
      public function DragPlayerElement()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.stateField = null;
         super.onDispose();
      }
      
      override protected function doResetData() : void
      {
         super.doResetData();
         this.stateField.text = Values.EMPTY_STR;
      }
      
      override protected function doUpdateData(param1:TrainingRoomRendererVO) : void
      {
         super.doUpdateData(param1);
         this.stateField.text = param1.stateString;
      }
   }
}
