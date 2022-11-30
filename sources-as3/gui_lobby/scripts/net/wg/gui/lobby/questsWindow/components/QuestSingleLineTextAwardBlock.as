package net.wg.gui.lobby.questsWindow.components
{
   public class QuestSingleLineTextAwardBlock extends QuestTextAwardBlock
   {
       
      
      private var _maxTfHeight:int = -1;
      
      public function QuestSingleLineTextAwardBlock()
      {
         super();
         this._maxTfHeight = textTf.height;
      }
      
      override protected function updateSize() : void
      {
         var _loc1_:int = Math.min(this._maxTfHeight,actualHeight);
         setSize(width,_loc1_);
         textTf.y = _loc1_ - textTf.height >> 1;
      }
      
      override protected function calcVisibleItemsLen(param1:Vector.<String>, param2:String, param3:String, param4:int) : int
      {
         App.utils.commons.truncateTextFieldText(textTf,param2,true,true);
         return 1;
      }
   }
}
