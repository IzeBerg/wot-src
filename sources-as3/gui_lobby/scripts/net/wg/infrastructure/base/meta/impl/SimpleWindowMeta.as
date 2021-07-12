package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.windows.vo.SimpleWindowBtnVo;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class SimpleWindowMeta extends AbstractWindowView
   {
       
      
      public var onBtnClick:Function;
      
      private var _vectorSimpleWindowBtnVo:Vector.<SimpleWindowBtnVo>;
      
      public function SimpleWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:SimpleWindowBtnVo = null;
         if(this._vectorSimpleWindowBtnVo)
         {
            for each(_loc1_ in this._vectorSimpleWindowBtnVo)
            {
               _loc1_.dispose();
            }
            this._vectorSimpleWindowBtnVo.splice(0,this._vectorSimpleWindowBtnVo.length);
            this._vectorSimpleWindowBtnVo = null;
         }
         super.onDispose();
      }
      
      public function onBtnClickS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onBtnClick,"onBtnClick" + Errors.CANT_NULL);
         this.onBtnClick(param1);
      }
      
      public final function as_setButtons(param1:Array, param2:String, param3:int) : void
      {
         var _loc7_:SimpleWindowBtnVo = null;
         var _loc4_:Vector.<SimpleWindowBtnVo> = this._vectorSimpleWindowBtnVo;
         this._vectorSimpleWindowBtnVo = new Vector.<SimpleWindowBtnVo>(0);
         var _loc5_:uint = param1.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            this._vectorSimpleWindowBtnVo[_loc6_] = new SimpleWindowBtnVo(param1[_loc6_]);
            _loc6_++;
         }
         this.setButtons(this._vectorSimpleWindowBtnVo,param2,param3);
         if(_loc4_)
         {
            for each(_loc7_ in _loc4_)
            {
               _loc7_.dispose();
            }
            _loc4_.splice(0,_loc4_.length);
         }
      }
      
      protected function setButtons(param1:Vector.<SimpleWindowBtnVo>, param2:String, param3:int) : void
      {
         var _loc4_:String = "as_setButtons" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc4_);
         throw new AbstractException(_loc4_);
      }
   }
}
