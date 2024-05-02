package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class AwardsListRendererVO extends DAAPIDataClass
   {
      
      private static const AWARDS:String = "awards";
      
      private static const TEXT_SEPARATOR:String = " ";
       
      
      public var icon:String = "";
      
      public var tooltip:String = "";
      
      public var positionDescr:String = "";
      
      public var awards:DataProvider = null;
      
      public function AwardsListRendererVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 == AWARDS)
         {
            _loc3_ = param2 as Array;
            if(_loc3_)
            {
               this.awards = new DataProvider();
               _loc4_ = _loc3_.length;
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  this.awards.push(new AwardItemRendererExVO(_loc3_[_loc5_]));
                  _loc5_++;
               }
            }
            else
            {
               App.utils.asserter.assert(false,param1 + TEXT_SEPARATOR + Errors.INVALID_TYPE + Array);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this.awards)
         {
            _loc1_.dispose();
         }
         this.awards.cleanUp();
         this.awards = null;
         super.onDispose();
      }
   }
}
