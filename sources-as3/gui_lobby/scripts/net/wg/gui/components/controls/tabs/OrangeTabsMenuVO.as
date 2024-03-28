package net.wg.gui.components.controls.tabs
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class OrangeTabsMenuVO extends DAAPIDataClass
   {
       
      
      public var id:String = "";
      
      public var label:String = "";
      
      public var linkage:String = "";
      
      public var viewId:String = "";
      
      public var selected:Boolean = false;
      
      public var enabled:Boolean = true;
      
      public function OrangeTabsMenuVO(param1:Object)
      {
         super(param1);
      }
      
      override public function toString() : String
      {
         return "\n[OrangeTabsMenuVO > " + "id: " + this.id + ", label: " + this.label + ", linkage: " + this.linkage + ", viewId:" + this.viewId + ", selected: " + this.selected + ", enabled: " + this.enabled + "]";
      }
   }
}
