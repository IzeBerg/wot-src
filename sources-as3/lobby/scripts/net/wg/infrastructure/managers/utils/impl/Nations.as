package net.wg.infrastructure.managers.utils.impl
{
   import net.wg.utils.INations;
   import net.wg.utils.IUtils;
   
   public class Nations implements INations
   {
       
      
      protected var _utilsProxy:IUtils = null;
      
      public function Nations(param1:IUtils)
      {
         super();
         this._utilsProxy = param1;
      }
      
      public function getNationName(param1:uint) : String
      {
         return this._utilsProxy.getNationNamesS()[param1];
      }
      
      public function getNationID(param1:String) : uint
      {
         return this._utilsProxy.getNationIndicesS()[param1];
      }
      
      public function getNations() : Array
      {
         return this._utilsProxy.getGUINationsS();
      }
      
      public function getNationsData() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:Array = this.getNations();
         var _loc3_:Number = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_.push({
               "label":MENU.nations(_loc2_[_loc3_]),
               "data":this.getNationID(_loc2_[_loc3_])
            });
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function getNationIcon(param1:int) : String
      {
         return "../maps/icons/filters/nations/" + this.getNationName(param1) + ".png";
      }
   }
}
