package net.wg.gui.components.questProgress.components.headerProgress.iconDashed
{
   import flash.display.DisplayObject;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.gui.components.questProgress.components.headerProgress.HeaderProgressBase;
   import net.wg.gui.components.questProgress.components.headerProgress.dashed.HeaderProgressDash;
   import net.wg.gui.components.questProgress.interfaces.components.IHeaderProgressDash;
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   
   public class HeaderProgressIconDashed extends HeaderProgressBase
   {
      
      private static const DASH_GAP:int = 26;
       
      
      private var _dashes:Vector.<IHeaderProgressDash> = null;
      
      public function HeaderProgressIconDashed()
      {
         super();
      }
      
      override protected function onDataUpdate(param1:int, param2:IHeaderProgressData) : void
      {
         this.createDashes(param1,param2.value,param2.goal,param2.state);
         super.onDataUpdate(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.clearDashes();
         super.onDispose();
      }
      
      protected function getDashComponent() : IHeaderProgressDash
      {
         return App.utils.classFactory.getComponent(QUEST_PROGRESS_BASE.PROGRESS_DASHED_DASH_ICON,HeaderProgressDash);
      }
      
      protected function getDashGap() : int
      {
         return DASH_GAP;
      }
      
      private function createDashes(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:int = this.getDashGap();
         var _loc6_:Number = (param1 + _loc5_) / param3 | 0;
         var _loc7_:int = _loc6_ - _loc5_;
         this.clearDashes();
         this._dashes = new Vector.<IHeaderProgressDash>();
         var _loc8_:IHeaderProgressDash = null;
         var _loc9_:Number = 0;
         var _loc10_:String = Values.EMPTY_STR;
         var _loc11_:int = 0;
         while(_loc11_ < param3)
         {
            _loc8_ = this.getDashComponent();
            this._dashes.push(_loc8_);
            _loc8_.x = _loc9_ ^ 0;
            this.addChild(DisplayObject(_loc8_));
            if(param4 == QUEST_PROGRESS_BASE.FAILED_STATE)
            {
               _loc10_ = QUEST_PROGRESS_BASE.PROGRESS_DASHED_DASH_STATE_FAILED;
            }
            else if(_loc11_ < param2)
            {
               _loc10_ = QUEST_PROGRESS_BASE.PROGRESS_DASHED_DASH_STATE_SUCCESS;
            }
            else
            {
               _loc10_ = QUEST_PROGRESS_BASE.PROGRESS_DASHED_DASH_STATE_EMPTY;
            }
            _loc8_.setData(_loc7_,_loc10_,Boolean(_loc11_ == param3 - 1));
            _loc9_ += _loc6_;
            _loc11_++;
         }
      }
      
      private function clearDashes() : void
      {
         var _loc1_:IHeaderProgressDash = null;
         if(this._dashes)
         {
            for each(_loc1_ in this._dashes)
            {
               _loc1_.dispose();
               this.removeChild(DisplayObject(_loc1_));
            }
            this._dashes.splice(0,this._dashes.length);
            this._dashes = null;
         }
      }
   }
}
