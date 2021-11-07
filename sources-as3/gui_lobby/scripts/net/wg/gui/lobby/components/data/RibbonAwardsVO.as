package net.wg.gui.lobby.components.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.utils.IDataUtils;
   
   public class RibbonAwardsVO extends DAAPIDataClass
   {
      
      private static const AWARDS_FIELD:String = "awards";
       
      
      public var ribbonType:String = "";
      
      public var rendererLinkage:String = "";
      
      public var rendererWidth:int = -1;
      
      public var rendererHeight:int = -1;
      
      public var rendererYOffset:int = -1;
      
      public var gap:int = -1;
      
      public var awards:Array = null;
      
      public function RibbonAwardsVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == AWARDS_FIELD)
         {
            if(param2)
            {
               _loc3_ = param2 as Array;
               if(_loc3_)
               {
                  this.awards = [];
                  for each(_loc4_ in _loc3_)
                  {
                     this.awards.push(_loc4_);
                  }
               }
               else
               {
                  App.utils.asserter.assert(false,param1 + Errors.CANT_NULL);
               }
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDataUtils = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(this.awards)
         {
            _loc1_ = App.utils.data;
            _loc2_ = this.awards.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_.cleanupDynamicObject(this.awards[_loc3_]);
               _loc3_++;
            }
            this.awards.splice(0,_loc2_);
            this.awards = null;
         }
         super.onDispose();
      }
   }
}
