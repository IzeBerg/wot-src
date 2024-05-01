package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.constants.Values;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PrivateQuestsVO extends DAAPIDataClass
   {
       
      
      public var name:String = "";
      
      public var conditions:String = "";
      
      public var descr:String = "";
      
      public var params:Array = null;
      
      public var status:Boolean = false;
      
      public var statusHeader:String = "";
      
      public var statusLevel:String = "";
      
      public var statusText:String = "";
      
      public function PrivateQuestsVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == "status")
         {
            if(param2)
            {
               this.status = true;
               this.statusHeader = param2.hasOwnProperty("header") && param2.header != undefined ? param2.header : Values.EMPTY_STR;
               this.statusText = param2.hasOwnProperty("text") && param2.text != undefined ? param2.text : Values.EMPTY_STR;
               this.statusLevel = param2.hasOwnProperty("level") && param2.level != undefined ? param2.level : Values.EMPTY_STR;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.params = null;
         super.onDispose();
      }
   }
}
