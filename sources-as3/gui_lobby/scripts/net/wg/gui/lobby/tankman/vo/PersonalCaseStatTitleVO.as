package net.wg.gui.lobby.tankman.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PersonalCaseStatTitleVO extends DAAPIDataClass
   {
      
      private static const STATS_DATA:String = "stats";
       
      
      public var label:String = "";
      
      public var secondLabel:String = "";
      
      public var isPremium:Boolean = false;
      
      public var isRowSeparator:Boolean = false;
      
      public function PersonalCaseStatTitleVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this.label = null;
         this.secondLabel = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == STATS_DATA)
         {
            return false;
         }
         return true;
      }
   }
}
