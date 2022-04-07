package net.wg.gui.crewOperations
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CrewOperationInfoVO extends DAAPIDataClass
   {
       
      
      public var id:String = "";
      
      public var iconPath:String = "";
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var error:String = "";
      
      public var warning:Object;
      
      private var _warningVO:CrewOperationWarningVO;
      
      public var btnLabel:String = "";
      
      public var btnNotificationEnabled:Boolean;
      
      public function CrewOperationInfoVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == "warning" && param2)
         {
            this._warningVO = new CrewOperationWarningVO(param2);
            return false;
         }
         return this.hasOwnProperty(param1);
      }
      
      public function get warningVO() : CrewOperationWarningVO
      {
         return this._warningVO;
      }
   }
}
