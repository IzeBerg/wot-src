package net.wg.gui.login.impl.components
{
   import fl.transitions.easing.Strong;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import net.wg.data.constants.Errors;
   import net.wg.gui.login.IRssNewsFeedRenderer;
   import net.wg.gui.login.impl.vo.RssItemVo;
   import net.wg.gui.utils.ExcludeTweenManager;
   import net.wg.infrastructure.base.meta.IRssNewsFeedMeta;
   import net.wg.infrastructure.base.meta.impl.RssNewsFeedMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   import scaleform.clik.utils.Padding;
   
   public class RssNewsFeed extends RssNewsFeedMeta implements IRssNewsFeedMeta
   {
       
      
      public var container:Sprite = null;
      
      public var bg:Sprite = null;
      
      private var rssItems:Vector.<RssNewsFeedRenderer> = null;
      
      private var rssItemsVo:Vector.<RssItemVo> = null;
      
      private const MARGIN_BETWEEN_ITEMS:Number = 13;
      
      private const RENDERER_CLASS_REFERENCE:String = "RssNewsFeedRendererUI";
      
      private var _padding:Padding;
      
      private var moveTween:Tween = null;
      
      private var tweenManager:ExcludeTweenManager;
      
      public function RssNewsFeed()
      {
