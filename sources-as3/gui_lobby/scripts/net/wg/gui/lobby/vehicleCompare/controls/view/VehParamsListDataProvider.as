package net.wg.gui.lobby.vehicleCompare.controls.view
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import net.wg.data.constants.generated.HANGAR_ALIASES;
   import net.wg.gui.lobby.components.data.VehParamVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class VehParamsListDataProvider extends DataProvider
   {
       
      
      private var _source:Array;
      
      public function VehParamsListDataProvider(param1:Array = null)
      {
         var _loc2_:Object = null;
         var _loc3_:VehParamVO = null;
         this._source = [];
         super();
         for each(_loc2_ in param1)
         {
            _loc3_ = new VehParamVO(_loc2_);
            this._source.push(_loc3_);
         }
         dispatcher = new EventDispatcher(this);
         this.parseSource(this._source);
      }
      
      private static function isParentElement(param1:String) : Boolean
      {
         return param1 == HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_SIMPLE_TOP;
      }
      
      override public function cleanUp() : void
      {
         var _loc1_:IDisposable = null;
         super.cleanUp();
         if(this._source)
         {
            for each(_loc1_ in this._source)
            {
               _loc1_.dispose();
            }
            this._source.splice(0,this._source.length);
         }
         this._source = null;
      }
      
      override protected function parseSource(param1:Array) : void
      {
         var _loc2_:VehParamVO = null;
         if(param1 == null)
         {
            return;
         }
         var _loc3_:uint = 0;
         var _loc4_:Boolean = true;
         var _loc5_:uint = param1.length;
         var _loc6_:uint = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = VehParamVO(param1[_loc6_]);
            if(isParentElement(_loc2_.state))
            {
               _loc4_ = _loc2_.isOpen;
               this[_loc6_ - _loc3_] = param1[_loc6_];
            }
            else if(_loc4_)
            {
               this[_loc6_ - _loc3_] = param1[_loc6_];
            }
            else
            {
               _loc3_++;
            }
            _loc6_++;
         }
      }
      
      public function getItemAt(param1:int) : VehParamVO
      {
         return this[param1];
      }
      
      public function update() : void
      {
         super.cleanUp();
         this.parseSource(this._source);
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function get originalLength() : int
      {
         return this._source.length;
      }
   }
}
