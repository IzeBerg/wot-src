package net.wg.gui.components.common.counters
{
   import flash.display.FrameLabel;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.RESEARCH_COUNTER_STATES;
   
   public class CounterVehResearch extends CounterBase
   {
      
      private static const VEH_STATE:Vector.<String> = new <String>[RESEARCH_COUNTER_STATES.RESEARCH_VEHICLE_AVAILABLE,RESEARCH_COUNTER_STATES.RESEARCH_VEHICLE_AVAILABLE_FORCED];
       
      
      public var labelTf:CounterLabel = null;
      
      private var _transitions:Vector.<String>;
      
      private var _state:String = "none";
      
      public function CounterVehResearch()
      {
         var _loc2_:FrameLabel = null;
         this._transitions = new Vector.<String>(0);
         super();
         var _loc1_:Array = currentLabels;
         for each(_loc2_ in _loc1_)
         {
            this._transitions.push(_loc2_.name);
         }
      }
      
      override protected function getDefaultState() : String
      {
         return RESEARCH_COUNTER_STATES.RESEARCH_NOT_AVAILABLE;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.labelTf.setTextAutoSize(TextFieldAutoSize.CENTER);
      }
      
      override protected function onDispose() : void
      {
         stop();
         this._transitions.splice(0,this._transitions.length);
         this._transitions = null;
         this.labelTf.dispose();
         this.labelTf = null;
         super.onDispose();
      }
      
      override protected function applyPosition() : void
      {
         var _loc1_:Rectangle = this.target.getBounds(this.target.parent);
         x = _loc1_.x + _loc1_.width | 0;
         y = _loc1_.y | 0;
         if(this.offset != null)
         {
            x += this.offset.x | 0;
            y += this.offset.y | 0;
         }
      }
      
      override protected function applyState() : void
      {
         super.applyState();
         var _loc1_:String = this.getFrameState(this.viewState);
         if(this._transitions.indexOf(_loc1_) == -1)
         {
            return;
         }
         this._state = _loc1_;
         gotoAndPlay(_loc1_);
      }
      
      override protected function applyCountValue() : void
      {
         this.labelTf.text = value;
         super.applyCountValue();
      }
      
      private function getFrameState(param1:String) : String
      {
         if(this._state == RESEARCH_COUNTER_STATES.RESEARCH_NOT_AVAILABLE)
         {
            if(param1 == RESEARCH_COUNTER_STATES.RESEARCH_MODULE_AVAILABLE)
            {
               return RESEARCH_COUNTER_STATES.RESEARCH_MODULE_AVAILABLE_FORCED;
            }
            if(param1 == RESEARCH_COUNTER_STATES.RESEARCH_VEHICLE_AVAILABLE)
            {
               return RESEARCH_COUNTER_STATES.RESEARCH_VEHICLE_AVAILABLE_FORCED;
            }
         }
         if(VEH_STATE.indexOf(this._state) >= 0 && param1 == RESEARCH_COUNTER_STATES.RESEARCH_MODULE_AVAILABLE)
         {
            return RESEARCH_COUNTER_STATES.TRANSITION_VEHICLE_TO_MODULE;
         }
         return param1;
      }
   }
}
