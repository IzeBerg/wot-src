package net.wg.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TutorialComponentRect extends DAAPIDataClass
   {
       
      
      public var x:int = -1;
      
      public var y:int = -1;
      
      public var width:int = -1;
      
      public var height:int = -1;
      
      public function TutorialComponentRect(param1:Object = null)
      {
         super(param1);
      }
      
      override public function toString() : String
      {
         return "[TutorialComponentRect " + this.x + ", " + this.y + ", " + this.width + ", " + this.height + " ]";
      }
   }
}
