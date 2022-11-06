package net.wg.gui.lobby.battleMatters.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class LinkedSetHintsVO extends DAAPIDataClass
   {
      
      private static const AWARDS:String = "awards";
       
      
      public var icon:String = "";
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var awards:Vector.<LinkedSetAwardVO>;
      
      public var buttonLabel:String = "";
      
      public var back:String = "";
      
      public function LinkedSetHintsVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == AWARDS)
         {
            this.awards = new Vector.<LinkedSetAwardVO>(0);
            for each(_loc3_ in param2)
            {
               this.awards.push(new LinkedSetAwardVO(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:LinkedSetAwardVO = null;
         for each(_loc1_ in this.awards)
         {
            _loc1_.dispose();
         }
         this.awards.length = 0;
         this.awards = null;
         super.onDispose();
      }
   }
}
