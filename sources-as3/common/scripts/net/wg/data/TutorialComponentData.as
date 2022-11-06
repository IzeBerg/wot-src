package net.wg.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TutorialComponentData extends DAAPIDataClass
   {
       
      
      public var rect:TutorialComponentRect = null;
      
      public function TutorialComponentData(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == "rect")
         {
            this.rect = new TutorialComponentRect(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override public function toString() : String
      {
         return "[TutorialComponentData " + this.rect + " ]";
      }
   }
}
