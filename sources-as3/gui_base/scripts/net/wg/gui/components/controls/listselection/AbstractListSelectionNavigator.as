package net.wg.gui.components.controls.listselection
{
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class AbstractListSelectionNavigator implements IDisposable
   {
      
      private static const ABSTRACT_METHOD_NAME:String = "ListSelectionNavigator.isSelectable";
       
      
      private var _dataProvider:IDataProvider;
      
      public function AbstractListSelectionNavigator()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._dataProvider = null;
      }
      
      public function navigate(param1:int, param2:ListSelectionDirection, param3:Boolean) : int
      {
         var _loc4_:int = param1;
         var _loc5_:int = param2.value;
         var _loc6_:int = this._dataProvider.length - 1;
         while(_loc4_ >= 0 && !this.isSelectable(_loc4_))
         {
            _loc4_ += _loc5_;
            if(param3)
            {
               if(_loc4_ > _loc6_)
               {
                  _loc4_ = 0;
               }
               else if(_loc4_ < 0)
               {
                  _loc4_ = _loc6_;
               }
               if(_loc4_ == param1)
               {
                  return Values.DEFAULT_INT;
               }
            }
            else if(_loc4_ > _loc6_ || _loc4_ < 0)
            {
               _loc4_ = Values.DEFAULT_INT;
               break;
            }
         }
         return _loc4_;
      }
      
      protected function isSelectable(param1:int) : Boolean
      {
         throw new AbstractException(ABSTRACT_METHOD_NAME + Errors.ABSTRACT_INVOKE);
      }
      
      protected function getItemByIndex(param1:uint) : Object
      {
         return this._dataProvider.requestItemAt(param1);
      }
      
      public function set dataProvider(param1:IDataProvider) : void
      {
         this._dataProvider = param1;
      }
   }
}
