package net.wg.gui.rally.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SettingRosterVO extends DAAPIDataClass
   {
       
      
      public var vLevelRange:Array = null;
      
      public var vTypeRange:Array = null;
      
      private var _nationIDRange:Array = null;
      
      public function SettingRosterVO(param1:Object = null)
      {
         super(param1);
      }
      
      private static function sortNations(param1:Array) : Array
      {
         var _loc2_:Array = App.utils.getGUINationsS();
         var _loc3_:Array = [];
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(param1.indexOf(_loc2_[_loc4_]) > -1)
            {
               _loc3_.push(_loc2_[_loc4_]);
            }
            _loc4_++;
         }
         _loc2_.splice(0,_loc2_.length);
         return _loc3_;
      }
      
      override protected function onDispose() : void
      {
         this.clearRange();
         super.onDispose();
      }
      
      public function clearRange() : void
      {
         if(this._nationIDRange != null)
         {
            this._nationIDRange.splice(0,this._nationIDRange.length);
         }
         if(this.vLevelRange != null)
         {
            this.vLevelRange.splice(0,this.vLevelRange.length);
         }
         if(this.vTypeRange != null)
         {
            this.vTypeRange.splice(0,this.vTypeRange.length);
         }
      }
      
      public function get nationIDRange() : Array
      {
         return this._nationIDRange;
      }
      
      public function set nationIDRange(param1:Array) : void
      {
         this._nationIDRange = Boolean(param1) ? sortNations(param1) : param1;
      }
   }
}
