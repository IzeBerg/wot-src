package net.wg.data.VO.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DAAPITriggeredCommandsVO extends DAAPIDataClass
   {
      
      private static const CHAT_COMMAND:String = "chatCommands";
       
      
      public var triggeredCommands:Vector.<DAAPITriggeredCommandVO> = null;
      
      public function DAAPITriggeredCommandsVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         switch(param1)
         {
            case CHAT_COMMAND:
               this.triggeredCommands = Vector.<DAAPITriggeredCommandVO>(App.utils.data.convertVOArrayToVector(param1,param2,DAAPITriggeredCommandVO));
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:DAAPITriggeredCommandVO = null;
         if(this.triggeredCommands)
         {
            for each(_loc1_ in this.triggeredCommands)
            {
               _loc1_.dispose();
            }
            this.triggeredCommands.fixed = false;
            this.triggeredCommands.splice(0,this.triggeredCommands.length);
            this.triggeredCommands = null;
         }
         super.onDispose();
      }
   }
}
