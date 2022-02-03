package net.wg.gui.battle.views.prebattleInfo.questInfo
{
   import flash.display.Sprite;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class QuestInfoFlagTaskIcoContainer extends Sprite implements IDisposable
   {
       
      
      public var taskIco:UILoaderAlt = null;
      
      private var _disposed:Boolean = false;
      
      public function QuestInfoFlagTaskIcoContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.taskIco.dispose();
         this.taskIco = null;
      }
      
      public function setData(param1:String) : void
      {
         this.taskIco.source = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
