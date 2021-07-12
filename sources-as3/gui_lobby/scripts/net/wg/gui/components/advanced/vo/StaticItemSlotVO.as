package net.wg.gui.components.advanced.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class StaticItemSlotVO extends DAAPIDataClass
   {
       
      
      public var highlight:Boolean = false;
      
      public var moduleType:String = "";
      
      public var iconSource:String = "";
      
      public var isBgVisible:Boolean = false;
      
      public var overlayType:String = "";
      
      public var bgHighlightType:String = "";
      
      public function StaticItemSlotVO(param1:Object)
      {
         super(param1);
      }
   }
}
