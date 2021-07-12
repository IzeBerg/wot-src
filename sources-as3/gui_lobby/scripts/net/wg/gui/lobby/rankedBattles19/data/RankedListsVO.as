package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RankedListsVO extends DAAPIDataClass
   {
      
      private static const FIELD_TOPS:String = "tops";
       
      
      public var title:String = "";
      
      public var titleAlpha:Number = 1;
      
      public var tops:Vector.<RankedListVO> = null;
      
      public function RankedListsVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == FIELD_TOPS)
         {
            _loc3_ = param2 as Array;
            if(!_loc3_)
            {
               App.utils.asserter.assert(Boolean(_loc3_),param1 + Errors.INVALID_TYPE);
            }
            else
            {
               _loc4_ = null;
               this.tops = new Vector.<RankedListVO>();
               for each(_loc4_ in _loc3_)
               {
                  this.tops.push(new RankedListVO(_loc4_));
               }
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this.tops)
         {
            _loc1_.dispose();
         }
         this.tops = null;
         super.onDispose();
      }
   }
}
