package net.wg.gui.battle.eventBattle.views.phaseIndicator
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.base.meta.IPhaseIndicatorMeta;
   import net.wg.infrastructure.base.meta.impl.PhaseIndicatorMeta;
   import net.wg.utils.ILocale;
   import scaleform.gfx.TextFieldEx;
   
   public class PhaseIndicator extends PhaseIndicatorMeta implements IPhaseIndicatorMeta
   {
       
      
      public var textfield:TextField;
      
      private var _current:int;
      
      private var _total:int;
      
      private var _locale:ILocale;
      
      private var _isVisible:Boolean = false;
      
      public function PhaseIndicator()
      {
         this._locale = App.utils.locale;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         TextFieldEx.setNoTranslate(this.textfield,true);
         this.textfield.autoSize = TextFieldAutoSize.RIGHT;
      }
      
      override protected function onDispose() : void
      {
         this.textfield = null;
         this._locale = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._isVisible)
            {
               this.textfield.text = this._locale.makeString(EVENT.ARENA_PHASE,{
                  "current":this._current.toString(),
                  "total":this._total.toString()
               });
            }
            else
            {
               this.textfield.text = Values.EMPTY_STR;
            }
         }
      }
      
      public function as_setData(param1:int, param2:int) : void
      {
         if(this._current != param1)
         {
            this._current = param1;
            invalidateData();
         }
         if(this._total != param2)
         {
            this._total = param2;
            invalidateData();
         }
      }
      
      public function as_setVisible(param1:Boolean) : void
      {
         if(this._isVisible != param1)
         {
            this._isVisible = param1;
            invalidateData();
         }
      }
   }
}
