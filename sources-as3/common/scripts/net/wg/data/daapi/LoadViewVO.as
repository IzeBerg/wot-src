package net.wg.data.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class LoadViewVO extends DAAPIDataClass
   {
      
      public static const CONFIG_FIELD_NAME:String = "config";
       
      
      public var configVO:ViewSettingsVO;
      
      public var alias:String = "";
      
      public var name:String = "";
      
      public var viewTutorialId:String = "";
      
      public var cached:Boolean;
      
      public function LoadViewVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == CONFIG_FIELD_NAME)
         {
            this.configVO = new ViewSettingsVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.configVO.dispose();
         this.configVO = null;
         super.onDispose();
      }
      
      override public function toString() : String
      {
         return "[" + "LoadViewVO: " + this.alias + "]";
      }
   }
}
