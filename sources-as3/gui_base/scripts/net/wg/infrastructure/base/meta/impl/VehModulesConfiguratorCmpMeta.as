package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.battleRoyale.data.ConfiguratorColumnVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class VehModulesConfiguratorCmpMeta extends BaseDAAPIComponent
   {
       
      
      public var onClick:Function;
      
      private var _vectorConfiguratorColumnVO:Vector.<ConfiguratorColumnVO>;
      
      private var _vectorConfiguratorColumnVO1:Vector.<ConfiguratorColumnVO>;
      
      public function VehModulesConfiguratorCmpMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:ConfiguratorColumnVO = null;
         var _loc2_:ConfiguratorColumnVO = null;
         if(this._vectorConfiguratorColumnVO)
         {
            for each(_loc1_ in this._vectorConfiguratorColumnVO)
            {
               _loc1_.dispose();
            }
            this._vectorConfiguratorColumnVO.splice(0,this._vectorConfiguratorColumnVO.length);
            this._vectorConfiguratorColumnVO = null;
         }
         if(this._vectorConfiguratorColumnVO1)
         {
            for each(_loc2_ in this._vectorConfiguratorColumnVO1)
            {
               _loc2_.dispose();
            }
            this._vectorConfiguratorColumnVO1.splice(0,this._vectorConfiguratorColumnVO1.length);
            this._vectorConfiguratorColumnVO1 = null;
         }
         super.onDispose();
      }
      
      public function onClickS(param1:int, param2:int, param3:int) : void
      {
         App.utils.asserter.assertNotNull(this.onClick,"onClick" + Errors.CANT_NULL);
         this.onClick(param1,param2,param3);
      }
      
      public final function as_setItems(param1:Array) : void
      {
         var _loc5_:ConfiguratorColumnVO = null;
         var _loc2_:Vector.<ConfiguratorColumnVO> = this._vectorConfiguratorColumnVO;
         this._vectorConfiguratorColumnVO = new Vector.<ConfiguratorColumnVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorConfiguratorColumnVO[_loc4_] = new ConfiguratorColumnVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setItems(this._vectorConfiguratorColumnVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_updateItems(param1:Array) : void
      {
         var _loc5_:ConfiguratorColumnVO = null;
         var _loc2_:Vector.<ConfiguratorColumnVO> = this._vectorConfiguratorColumnVO1;
         this._vectorConfiguratorColumnVO1 = new Vector.<ConfiguratorColumnVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorConfiguratorColumnVO1[_loc4_] = new ConfiguratorColumnVO(param1[_loc4_]);
            _loc4_++;
         }
         this.updateItems(this._vectorConfiguratorColumnVO1);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setItems(param1:Vector.<ConfiguratorColumnVO>) : void
      {
         var _loc2_:String = "as_setItems" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateItems(param1:Vector.<ConfiguratorColumnVO>) : void
      {
         var _loc2_:String = "as_updateItems" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
