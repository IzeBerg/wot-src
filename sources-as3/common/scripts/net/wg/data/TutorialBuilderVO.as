package net.wg.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TutorialBuilderVO extends DAAPIDataClass
   {
       
      
      public var builder:String = "";
      
      public var data:Object = null;
      
      public function TutorialBuilderVO(param1:Object)
      {
         super(param1);
      }
      
      override public function toString() : String
      {
         return "[TutorialBuilderVO " + this.builder + ", " + this.data + " ]";
      }
      
      override protected function onDispose() : void
      {
         this.data = null;
         super.onDispose();
      }
   }
}
