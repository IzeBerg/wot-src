package net.wg.gui.lobby.quests.data.seasonAwards
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SeasonAwardsVO extends DAAPIDataClass
   {
      
      private static const AWARDS_FIELD_NAME:String = "awards";
       
      
      public var windowTitle:String = "";
      
      public var visibleTabs:Boolean = true;
      
      public var awards:Array = null;
      
      public function SeasonAwardsVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         switch(param1)
         {
            case AWARDS_FIELD_NAME:
               _loc3_ = param2 as Array;
               App.utils.asserter.assertNotNull(_loc3_,AWARDS_FIELD_NAME + Errors.CANT_NULL);
               this.awards = [];
               for each(_loc4_ in _loc3_)
               {
                  this.awards.push(new SeasonAwardListRendererVO(_loc4_));
               }
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.awards != null)
         {
            for each(_loc1_ in this.awards)
            {
               _loc1_.dispose();
            }
            this.awards.splice(0,this.awards.length);
            this.awards = null;
         }
         super.onDispose();
      }
   }
}
