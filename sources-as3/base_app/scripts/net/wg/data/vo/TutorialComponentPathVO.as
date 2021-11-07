package net.wg.data.vo
{
   import flash.display.DisplayObject;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TutorialComponentPathVO extends DAAPIDataClass
   {
       
      
      public var viewTutorialId:String = "";
      
      public var viewName:String = "";
      
      public var path:String = "";
      
      public var id:String = "";
      
      public var foundComponent:DisplayObject;
      
      public function TutorialComponentPathVO(param1:Object)
      {
         super(param1);
      }
      
      override public function toString() : String
      {
         return "[TutorialComponentPathVO " + this.viewName + ", " + this.path + ", " + this.foundComponent + ", " + this.viewTutorialId + "]";
      }
   }
}
