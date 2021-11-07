package net.wg.gui.components.questProgress
{
   import flash.display.Sprite;
   import net.wg.gui.components.questProgress.interfaces.components.IQPItemOrConditionIcon;
   import net.wg.gui.components.questProgress.interfaces.components.IQPItemRenderer;
   
   public class QuestProgressOrCondition extends Sprite implements IQPItemOrConditionIcon
   {
       
      
      private var _previousItem:IQPItemRenderer = null;
      
      private var _item:IQPItemRenderer = null;
      
      public function QuestProgressOrCondition()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function setItems(param1:IQPItemRenderer, param2:IQPItemRenderer) : void
      {
         this._previousItem = param1;
         this._item = param2;
      }
      
      protected function onDispose() : void
      {
         this._previousItem = null;
         this._item = null;
      }
      
      public function get item() : IQPItemRenderer
      {
         return this._item;
      }
      
      public function get previousItem() : IQPItemRenderer
      {
         return this._previousItem;
      }
   }
}
