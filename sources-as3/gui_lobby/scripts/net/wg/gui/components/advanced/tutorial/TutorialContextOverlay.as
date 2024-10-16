package net.wg.gui.components.advanced.tutorial
{
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.vo.TutorialContextHintVO;
   import net.wg.gui.components.advanced.vo.TutorialContextOverlayVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class TutorialContextOverlay extends UIComponentEx
   {
       
      
      private var _model:TutorialContextOverlayVO = null;
      
      private var _hints:Vector.<TutorialContextHint> = null;
      
      public function TutorialContextOverlay()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function onDispose() : void
      {
         this.removeHints();
         this._model = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.layoutHints();
         }
      }
      
      public function setData(param1:TutorialContextOverlayVO) : void
      {
         var _loc3_:int = 0;
         if(param1 != null)
         {
            this._model = param1;
         }
         this.removeHints();
         if(!this._model)
         {
            return;
         }
         var _loc2_:int = this._model.hints.length;
         if(_loc2_ > 0)
         {
            this._hints = new Vector.<TutorialContextHint>();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this.addHint(this._model.hints[_loc3_]);
               _loc3_++;
            }
         }
         invalidateSize();
      }
      
      private function addHint(param1:TutorialContextHintVO) : void
      {
         var _loc2_:TutorialContextHint = App.utils.classFactory.getComponent(Linkages.TUTORIAL_CONTEXT_HINT_UI,TutorialContextHint);
         _loc2_.setData(param1);
         addChild(_loc2_);
         this._hints.push(_loc2_);
      }
      
      private function layoutHints() : void
      {
         var _loc3_:TutorialContextHint = null;
         var _loc1_:int = this._hints.length;
         var _loc2_:TutorialContextHintVO = null;
         _loc3_ = null;
         var _loc4_:int = 0;
         while(_loc4_ < _loc1_)
         {
            _loc2_ = this._model.hints[_loc4_];
            _loc3_ = this._hints[_loc4_];
            _loc3_.x = _loc2_.padding.left;
            _loc3_.y = _loc2_.padding.top;
            _loc3_.width = _loc2_.width != Values.DEFAULT_INT ? Number(_loc2_.width) : Number(_width - _loc2_.padding.left - _loc2_.padding.right);
            _loc3_.height = _loc2_.height != Values.DEFAULT_INT ? Number(_loc2_.height) : Number(_height - _loc2_.padding.top - _loc2_.padding.bottom);
            _loc4_++;
         }
      }
      
      private function removeHints() : void
      {
         var _loc1_:TutorialContextHint = null;
         if(this._hints != null)
         {
            for each(_loc1_ in this._hints)
            {
               _loc1_.dispose();
            }
            this._hints.splice(0,this._hints.length);
            this._hints = null;
         }
      }
   }
}
