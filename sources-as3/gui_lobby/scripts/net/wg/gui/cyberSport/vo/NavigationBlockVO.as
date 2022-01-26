package net.wg.gui.cyberSport.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class NavigationBlockVO extends DAAPIDataClass
   {
       
      
      public var previousVisible:Boolean = false;
      
      public var previousEnabled:Boolean = false;
      
      public var nextVisible:Boolean = false;
      
      public var nextEnabled:Boolean = false;
      
      public function NavigationBlockVO(param1:Object)
      {
         super(param1);
      }
   }
}
