package net.wg.mock
{
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   
   public class MockColorSchemeManager implements IColorSchemeManager
   {
       
      
      public function MockColorSchemeManager()
      {
         super();
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
      }
      
      public function as_update() : void
      {
      }
      
      public function getAliasColor(param1:String) : String
      {
         return "";
      }
      
      public function getColorSchemeS(param1:String) : Object
      {
         return null;
      }
      
      public function getRGB(param1:String) : Number
      {
         return 0;
      }
      
      public function getScheme(param1:String) : IColorScheme
      {
         return null;
      }
      
      public function getTransform(param1:String) : ColorTransform
      {
         return null;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return false;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return false;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return false;
      }
      
      public function getIsColorBlindS() : Boolean
      {
         return false;
      }
   }
}
