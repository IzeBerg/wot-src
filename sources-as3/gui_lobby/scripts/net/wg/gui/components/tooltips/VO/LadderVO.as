package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class LadderVO extends DAAPIDataClass
   {
       
      
      public var name:String = "";
      
      public var icon:String = "";
      
      public var place:String = "";
      
      public var state:String = "";
      
      public var points:String = "";
      
      public var status:String = "";
      
      public var season:String = "";
      
      public function LadderVO(param1:Object)
      {
         super(param1);
      }
   }
}
