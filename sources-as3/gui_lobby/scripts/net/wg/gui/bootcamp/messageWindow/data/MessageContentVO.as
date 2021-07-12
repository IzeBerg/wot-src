package net.wg.gui.bootcamp.messageWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import scaleform.clik.data.DataProvider;
   
   public class MessageContentVO extends DAAPIDataClass
   {
      
      private static const BOTTOM_DATA_FIELD:String = "bottomData";
       
      
      public var label:String = "";
      
      public var message:String = "";
      
      public var labelExecute:String = "";
      
      public var costValue:int = 0;
      
      public var isBuy:Boolean = false;
      
      public var isTraining:Boolean = true;
      
      public var referralDescription:String = "";
      
      public var messagePreset:String = "";
      
      public var icon:int = -1;
      
      public var iconPath:String = "";
      
      public var bottomRenderer:String = "";
      
      public var bottomData:DataProvider;
      
      public var background:String = "";
      
      public function MessageContentVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == BOTTOM_DATA_FIELD)
         {
            this.bottomData = new DataProvider();
            _loc3_ = param2 as Array;
            for each(_loc4_ in _loc3_)
            {
               this.bottomData.push(new MessageBottomItemVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:MessageBottomItemVO = null;
         if(this.bottomData)
         {
            for each(_loc1_ in this.bottomData)
            {
               if(_loc1_)
               {
                  _loc1_.dispose();
               }
            }
            this.bottomData.cleanUp();
            this.bottomData = null;
         }
         super.onDispose();
      }
   }
}
