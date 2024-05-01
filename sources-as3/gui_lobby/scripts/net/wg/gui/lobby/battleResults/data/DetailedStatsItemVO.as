package net.wg.gui.lobby.battleResults.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DetailedStatsItemVO extends DAAPIDataClass
   {
       
      
      public var label:String = "";
      
      public var col1:String = "";
      
      public var col2:String = "";
      
      public var col3:String = "";
      
      public var col4:String = "";
      
      public var lineType:String = "";
      
      public var labelStripped:String = "";
      
      public function DetailedStatsItemVO(param1:Object)
      {
         super(param1);
      }
   }
}
