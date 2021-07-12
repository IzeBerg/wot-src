package net.wg.gui.lobby.epicBattles.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EpicBattlesPrestigeProgressVO extends DAAPIDataClass
   {
      
      private static const PROGRESS_BLOCKS_FIELD:String = "progressBlocks";
       
      
      public var titleHtmlText:String = "";
      
      public var progressBlocks:Vector.<EpicBattlesPrestigeProgressBlockVO> = null;
      
      public function EpicBattlesPrestigeProgressVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == PROGRESS_BLOCKS_FIELD)
         {
            this.progressBlocks = new Vector.<EpicBattlesPrestigeProgressBlockVO>(0);
            for each(_loc3_ in param2)
            {
               this.progressBlocks.push(new EpicBattlesPrestigeProgressBlockVO(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:EpicBattlesPrestigeProgressBlockVO = null;
         if(this.progressBlocks)
         {
            for each(_loc1_ in this.progressBlocks)
            {
               _loc1_.dispose();
            }
            this.progressBlocks.splice(0,this.progressBlocks.length);
         }
         this.progressBlocks = null;
         super.onDispose();
      }
   }
}
