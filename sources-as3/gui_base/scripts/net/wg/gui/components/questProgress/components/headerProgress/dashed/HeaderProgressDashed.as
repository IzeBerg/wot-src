package net.wg.gui.components.questProgress.components.headerProgress.dashed
{
   import flash.display.DisplayObject;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.gui.components.questProgress.components.headerProgress.HeaderProgressBase;
   import net.wg.gui.components.questProgress.interfaces.components.IHeaderProgress;
   import net.wg.gui.components.questProgress.interfaces.components.IHeaderProgressDash;
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   
   public class HeaderProgressDashed extends HeaderProgressBase implements IHeaderProgress
   {
      
      private static const DASH_GAP:int = 5;
       
      
      private var _dashes:Vector.<IHeaderProgressDash> = null;
      
      public function HeaderProgressDashed()
      {
         super();
      }
      
      override protected function onDataUpdate(param1:int, param2:IHeaderProgressData) : void
      {
         if(param2.progress)
         {
            super.onDataUpdate(param1,param2);
            this.createPoints(param1,param2.progress);
         }
      }
      
      override protected function onDispose() : void
      {
         this.clearDashes();
         super.onDispose();
      }
      
      protected function getDashComponent() : IHeaderProgressDash
      {
         return App.utils.classFactory.getComponent(QUEST_PROGRESS_BASE.PROGRESS_DASHED_DASH,HeaderProgressDash);
      }
      
      private function createPoints(param1:int, param2:Array) : void
      {
         var _loc3_:int = param2.length;
         var _loc4_:Number = (param1 + DASH_GAP) / _loc3_;
         var _loc5_:int = _loc4_ - DASH_GAP;
         this.clearDashes();
         this._dashes = new Vector.<IHeaderProgressDash>();
         var _loc6_:IHeaderProgressDash = null;
         var _loc7_:Number = 0;
         var _loc8_:String = Values.EMPTY_STR;
         var _loc9_:int = 0;
         while(_loc9_ < _loc3_)
         {
            _loc6_ = this.getDashComponent();
            this._dashes.push(_loc6_);
            _loc6_.x = _loc7_ ^ 0;
            this.addChild(DisplayObject(_loc6_));
            switch(param2[_loc9_])
            {
               case QUEST_PROGRESS_BASE.HEADER_PROGRESS_BLOCK_NOT_STARTED:
                  _loc8_ = QUEST_PROGRESS_BASE.PROGRESS_DASHED_DASH_STATE_EMPTY;
                  break;
               case QUEST_PROGRESS_BASE.HEADER_PROGRESS_BLOCK_IN_PROGRESS:
                  _loc8_ = QUEST_PROGRESS_BASE.PROGRESS_DASHED_DASH_STATE_CURRENT;
                  break;
               case QUEST_PROGRESS_BASE.HEADER_PROGRESS_BLOCK_COMPLETED:
                  _loc8_ = QUEST_PROGRESS_BASE.PROGRESS_DASHED_DASH_STATE_SUCCESS;
                  break;
               case QUEST_PROGRESS_BASE.HEADER_PROGRESS_BLOCK_FAILED:
                  _loc8_ = QUEST_PROGRESS_BASE.PROGRESS_DASHED_DASH_STATE_FAILED;
                  break;
            }
            _loc6_.setData(_loc5_,_loc8_,Boolean(_loc9_ == _loc3_ - 1));
            _loc7_ += _loc4_;
            _loc9_++;
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
