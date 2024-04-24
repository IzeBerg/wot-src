package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DivisionVO extends DAAPIDataClass
   {
       
      
      public var id:String = "";
      
      public var name:String = "";
      
      public var isCompleted:Boolean = false;
      
      public var isLocked:Boolean = false;
      
      public var isCurrent:Boolean = false;
      
      public var isQualification:Boolean = false;
      
      public var linkage:String = "";
      
      public var viewId:String = "";
      
      public function DivisionVO(param1:Object)
      {
         super(param1);
      }
   }
}
