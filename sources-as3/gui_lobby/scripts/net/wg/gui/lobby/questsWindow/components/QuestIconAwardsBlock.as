package net.wg.gui.lobby.questsWindow.components
{
   import net.wg.gui.lobby.components.BaseAwardsBlock;
   import net.wg.gui.lobby.questsWindow.components.interfaces.IResizableContent;
   import net.wg.gui.lobby.questsWindow.data.QuestIconAwardsBlockVO;
   
   public class QuestIconAwardsBlock extends BaseAwardsBlock implements IResizableContent
   {
       
      
      private var _contentAlign:String;
      
      private var _data:QuestIconAwardsBlockVO;
      
      public function QuestIconAwardsBlock()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.tryClearData();
         super.onDispose();
      }
      
      public function setData(param1:Object) : void
      {
         this.tryClearData();
         this._data = new QuestIconAwardsBlockVO(param1);
         setAwardsData(this._data);
      }
      
      private function tryClearData() : void
      {
         if(this._data != null)
         {
            this._data.dispose();
            this._data = null;
         }
      }
      
      public function get isReadyForLayout() : Boolean
      {
         return true;
      }
      
      public function set isReadyForLayout(param1:Boolean) : void
      {
      }
      
      public function get availableWidth() : Number
      {
         return width;
      }
      
      public function set availableWidth(param1:Number) : void
      {
         width = param1;
      }
      
      public function get contentAlign() : String
      {
         return this._contentAlign;
      }
      
      public function set contentAlign(param1:String) : void
      {
         this._contentAlign = param1;
      }
      
      public function get isNumerated() : Boolean
      {
         return false;
      }
      
      public function set isNumerated(param1:Boolean) : void
      {
      }
   }
}
