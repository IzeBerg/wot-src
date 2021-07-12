package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class IgrVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var progressHeader:String = "";
      
      public var quests:Array = null;
      
      public var progress:Array = null;
      
      public var premVehQuests:Array = null;
      
      public function IgrVO(param1:Object)
      {
         super(param1);
      }
   }
}
