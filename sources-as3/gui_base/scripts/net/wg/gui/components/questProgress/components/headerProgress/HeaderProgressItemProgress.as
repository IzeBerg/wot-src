package net.wg.gui.components.questProgress.components.headerProgress
{
   import net.wg.gui.components.questProgress.interfaces.components.IHeaderProgress;
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   
   public class HeaderProgressItemProgress extends HeaderProgressItemValue
   {
       
      
      public var progress:IHeaderProgress = null;
      
      public function HeaderProgressItemProgress()
      {
         super();
      }
      
      override protected function onDataUpdate(param1:IHeaderProgressData, param2:int) : void
      {
         this.progress.setData(param1,param2);
         super.onDataUpdate(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.progress.dispose();
         this.progress = null;
         super.onDispose();
      }
   }
}
