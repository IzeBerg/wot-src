package net.wg.gui.lobby.clans.common
{
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.clans.profile.views.ClanProfileBaseView;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.utils.IUtils;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class ClanViewWithVariableContent extends ClanProfileBaseView
   {
       
      
      public var container:Sprite = null;
      
      protected var _content:BaseDAAPIComponent = null;
      
      protected var _contentLinkage:String = null;
      
      private var _utils:IUtils = null;
      
      private var _data:String = null;
      
      private var _linkagesDict:Dictionary;
      
      public function ClanViewWithVariableContent()
      {
         this._linkagesDict = new Dictionary();
         super();
         this.initializeContentLinkages();
      }
      
      override public function as_setData(param1:Object) : void
      {
         this._data = String(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._utils = App.utils;
      }
      
      override protected function onDispose() : void
      {
         if(this._content)
         {
            this.container.removeChild(this._content);
            this._content = null;
         }
         this.container = null;
         this._contentLinkage = null;
         this._utils.data.cleanupDynamicObject(this._linkagesDict);
         this._linkagesDict = null;
         this._utils = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.updateContent();
         }
      }
      
      public function addLinkageWithAlias(param1:String, param2:String) : void
      {
         this._linkagesDict[param1] = param2;
      }
      
      protected function initializeContentLinkages() : void
      {
         throw new AbstractException("ClanViewWithVariableContent.initializeContentLinkages" + Errors.ABSTRACT_INVOKE);
      }
      
      protected function updateContent() : void
      {
         if(this._contentLinkage == this._data)
         {
            return;
         }
         if(this._content)
         {
            this.container.removeChild(this._content);
            unregisterFlashComponentS(this.getComponentAlias(this._contentLinkage));
            this._content = null;
         }
         this._contentLinkage = this._data;
         this._content = this._utils.classFactory.getComponent(this._contentLinkage,BaseDAAPIComponent);
         this.container.addChild(this._content);
         registerFlashComponentS(this._content,this.getComponentAlias(this._contentLinkage));
      }
      
      private function getComponentAlias(param1:String) : String
      {
         var _loc2_:String = this._linkagesDict[param1];
         this._utils.asserter.assert(StringUtils.isNotEmpty(_loc2_),Errors.BAD_LINKAGE + param1);
         return _loc2_;
      }
   }
}
