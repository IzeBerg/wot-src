package net.wg.gui.battle.views.questProgress.animated
{
   import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressView;
   import net.wg.gui.components.questProgress.interfaces.data.IQPProgressData;
   
   public class UpdateViewDataQueueItem implements IQueueItem
   {
       
      
      private var _view:IQuestProgressView = null;
      
      private var _data:IQPProgressData = null;
      
      private var _id:String = null;
      
      private var _disposed:Boolean = false;
      
      public function UpdateViewDataQueueItem(param1:IQuestProgressView, param2:String, param3:IQPProgressData)
      {
         super();
         this._view = param1;
         this._data = param3;
         this._id = param2;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._view = null;
         this._data = null;
      }
      
      public function run(param1:Function) : void
      {
         this._view.update(this._id,this._data);
         param1();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
