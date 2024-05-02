package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.advanced.vo.ProgressBarAnimVO;
   
   public class ChainButtonVO extends DAAPIDataClass
   {
      
      private static const PROGRESS:String = "progress";
       
      
      public var chainID:int = -1;
      
      public var label:String = "";
      
      public var progressText:String = "";
      
      public var tankIcon:String = "";
      
      public var progress:ProgressBarAnimVO;
      
      public var tooltip:String = "";
      
      public function ChainButtonVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == PROGRESS && param2 != null)
         {
            this.progress = new ProgressBarAnimVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.progress != null)
         {
            this.progress.dispose();
            this.progress = null;
         }
         super.onDispose();
      }
   }
}
